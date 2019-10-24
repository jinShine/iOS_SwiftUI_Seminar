//
//  AddressSeachViewController.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import GoogleMaps

class AddressSearchViewController: BaseViewController, ViewType {
  
  //MARK: - Constant
  
  //MARK: - UI Properties
  lazy var mapView: GMSMapView = {
    let mapView = GMSMapView()
    mapView.settings.consumesGesturesInView = false
    mapView.isMyLocationEnabled = true
    mapView.delegate = self
    return mapView
  }()

  var marker: GMSMarker = {
    let marker = GMSMarker()
    marker.icon = UIImage(named: "Icon_pin")
    return marker
  }()

  var infoMarkerWindow: MapMarkerWindow?

  let popButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "Icon_Round_Left")
    button.setImage(image, for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()

  lazy var searchBar: SJSearchBar = {
    let searchBar = SJSearchBar()
    searchBar.textField.placeholder = "주소 검색"
    return searchBar
  }()

  let searchButton = SJButton(title: "검색", image: UIImage(named: "Icon_Checkmark"))

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  //MARK: - Properties
  var viewModel: AddressSearchViewModel!
  var disposeBag: DisposeBag!

  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    searchBar.textField.becomeFirstResponder()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    App.loading.hide()
  }

  //MARK: - Setup UI
  func setupUI() {
    view.insertSubview(mapView, at: 0)
    [searchBar, searchButton].forEach {
      mapView.addSubview($0)
    }
    infoMarkerWindow = MapMarkerWindow.loadView()
    setupNavigationBar(at: view, leftItem: popButton)
    navigationBaseView.backgroundColor = .clear
  }
  
  //MARK: - Setup Constraints
  func setupConstraints() {
    
    mapView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    searchBar.snp.makeConstraints {
      $0.top.equalTo(navigationBaseView.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
      $0.height.equalTo(56)
    }

    searchButton.snp.makeConstraints {
      $0.bottom.equalToSuperview().offset(-16)
      $0.leading.equalTo(searchBar)
      $0.trailing.equalTo(searchBar)
      $0.height.equalTo(56)
    }
  }
  
  //MARK: - Bind
  func bindViewModel() {

    //INPUT
    let didTapPopButton = popButton.rx.tap.asDriver()

    let locatoinStart = rx.viewWillAppear
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())

    let locationFetch = rx.viewWillAppear
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())

    let didSearch = searchButton.rx.tap
      .throttle(0.8, scheduler: MainScheduler.instance)
      .withLatestFrom(searchBar.textField.rx.text.orEmpty)
      .asDriver(onErrorJustReturn: "")

    let keyboardWillShow = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillShowNotification)

    let keyboardWillHide = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillHideNotification)

    let selectedAddress = infoMarkerWindow!.addSubject.asObserver()


    let input = AddressSearchViewModel.Input(didTapPopButton: didTapPopButton,
                                             locationStart: locatoinStart,
                                             locationFetch: locationFetch,
                                             didSearch: didSearch,
                                             keyboardWillShowTrigger: keyboardWillShow,
                                             keyboardWillHideTrigger: keyboardWillHide,
                                             selectedAddress: selectedAddress)

    //OUTPUT
    let output = viewModel.transform(input: input)

    output.popViewController
      .drive()
      .disposed(by: disposeBag)

    output.locationStart
      .drive()
      .disposed(by: disposeBag)

    output.locationUpdate
      .drive(cameraUpdateBinding)
      .disposed(by: disposeBag)

    let searchedShared = output.searchedGeocoder
      .asSharedSequence()

    searchedShared
      .filter { $0.address == "" && $0.geometry == nil }
      .drive(onNext: { _ in
        App.toast.info(message: "주소 결과가 없습니다.\n정확한 주소로 검색해주세요.", sender: self)
      })
      .disposed(by: disposeBag)

    searchedShared
      .filter { $0.address != "" && $0.geometry != nil }
      .do(onNext: { _ in self.dismissKeyboard() })
      .drive(locationUpdate)
      .disposed(by: disposeBag)

    output.keyboardHeight
      .do (onNext: { _ in self.searchButton.isHidden = false })
      .drive(onNext: {
        let keyboardHeightMargin = $0 + 8
        self.searchButton.snp.updateConstraints {
          $0.bottom.equalToSuperview().offset(-keyboardHeightMargin)
          $0.leading.equalTo(self.searchBar)
          $0.trailing.equalTo(self.searchBar)
          $0.height.equalTo(56)
        }
      })
    .disposed(by: disposeBag)

    output.keyboardDidHide
      .drive(onNext: { _ in self.searchButton.isHidden = true })
      .disposed(by: disposeBag)

  }
}

extension AddressSearchViewController {

  var cameraUpdateBinding: Binder<LocationResponse> {
    return Binder(self) { (vc, response) in
      guard response.error == nil else {
        switch response.error {
        case .authorizationDenied:
          App.toast.error(message: "원활한 서비스를 위해\n위치서비스를 활성화 시켜주세요.\n\n* 설정 -> Grouping앱 -> 위치 활성화",
                          sender: self, location: .top)
        default:
          App.toast.error(message: "지도 업데이트 에러", sender: self, location: .top)
        }
        return
      }

      if let location = response.location {
        vc.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 16.0)
      }
    }
  }

  var locationUpdate: Binder<GeocoderResult> {
    return Binder(self) { (vc, geocoder) in
      self.mapView.selectedMarker = nil
      if let location = geocoder.geometry?.location {
        let coordinate = CLLocationCoordinate2DMake(location.lat, location.lng)
        self.mapView.animate(toLocation: coordinate)
        self.marker.position = coordinate
        self.marker.title = geocoder.address
        self.marker.appearAnimation = GMSMarkerAnimation.pop
        self.marker.map = self.mapView
        self.mapView.selectedMarker = self.marker
      }
    }
  }
}

////MARK: - GMSMapView Delegate
extension AddressSearchViewController: GMSMapViewDelegate {

  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    dismissKeyboard()
  }

  func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
    return false
  }

  func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
    viewModel.geocoderSubject
      .map { $0.address }
      .subscribe(onNext: { self.infoMarkerWindow?.addressLabel.text = $0 })
      .disposed(by: disposeBag)
    
    return infoMarkerWindow
  }
}
