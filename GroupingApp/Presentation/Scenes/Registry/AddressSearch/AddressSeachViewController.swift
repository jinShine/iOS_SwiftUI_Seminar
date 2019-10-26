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
    searchBar.textField.returnKeyType = .search
    return searchBar
  }()
  
  let addressContainer: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  let addressLabel: UILabel = {
    let label = UILabel()
    label.font = App.font.regular(size: 14)
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    return label
  }()
  
  let addressDetailField: UITextField = {
    let field = UITextField()
    field.placeholder = "상세주소를 입력하세요 (건물명, 동/호수 등)"
    field.font = App.font.regular(size: 14)
    return field
  }()
  
  let setAddressButton = SJButton(title: "선택한 위치로 설정", image: UIImage(named: "Icon_Checkmark"))

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

    [mapView, addressContainer].forEach {
      self.view.addSubview($0)
    }
    [searchBar].forEach {
      mapView.addSubview($0)
    }
    [addressLabel, addressDetailField, setAddressButton].forEach {
      addressContainer.addSubview($0)
    }
    
    infoMarkerWindow = MapMarkerWindow.loadView()
    setupNavigationBar(at: view, leftItem: popButton)
    navigationBaseView.backgroundColor = .clear
  }
  
  //MARK: - Setup Constraints
  func setupConstraints() {
    
    mapView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.bottom.equalTo(addressContainer.snp.top)
    }

    searchBar.snp.makeConstraints {
      $0.top.equalTo(navigationBaseView.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
      $0.height.equalTo(56)
    }

    addressContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-(App.window?.safeAreaInsets.bottom ?? 0))
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(32)
    }
    
    addressDetailField.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.height.equalTo(32)
    }
    
    setAddressButton.snp.makeConstraints {
      $0.top.equalTo(addressDetailField.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview()
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
    
    let didSearch = searchBar.textField.rx.controlEvent(.editingDidEndOnExit)
      .throttle(0.8, scheduler: MainScheduler.instance)
      .withLatestFrom(searchBar.textField.rx.text.orEmpty)
      .asDriver(onErrorJustReturn: "")

    let keyboardWillShow = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillShowNotification)

    let keyboardWillHide = NotificationCenter.default.rx
      .notification(UIApplication.keyboardWillHideNotification)

    let didTapAddressSelect = infoMarkerWindow!.addSubject.asObserver()


    let input = AddressSearchViewModel.Input(didTapPopButton: didTapPopButton,
                                             locationStart: locatoinStart,
                                             locationFetch: locationFetch,
                                             didSearch: didSearch,
                                             keyboardWillShowTrigger: keyboardWillShow,
                                             keyboardWillHideTrigger: keyboardWillHide,
                                             didTapAddressSelect: didTapAddressSelect)

    //OUTPUT
    let output = viewModel.transform(input: input)

    output.popViewController
      .drive()
      .disposed(by: disposeBag)

    output.locationStart
      .drive()
      .disposed(by: disposeBag)
    
    output.locationUpdate
      .filter(locationError)
      .drive(cameraUpdate)
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
      .do(onNext: { _ in self.addressDetailField.becomeFirstResponder() })
      .drive(locationUpdate)
      .disposed(by: disposeBag)

    output.keyboardHeight
      .drive(onNext: { keyboardHeight in
        self.addressContainer.snp.updateConstraints {
          $0.bottom.equalToSuperview().offset(-keyboardHeight)
        }
        UIView.animate(withDuration: 0.35) {
          self.view.layoutIfNeeded()
        }
      })
    .disposed(by: disposeBag)

    output.keyboardDidHide
      .drive(onNext: { _ in
        self.addressContainer.snp.updateConstraints {
          $0.bottom.equalToSuperview().offset(-(App.window?.safeAreaInsets.bottom ?? 0))
        }
        UIView.animate(withDuration: 0.35) {
          self.view.layoutIfNeeded()
        }
      })
      .disposed(by: disposeBag)
    
    output.getInfoMarker
      .map { $0.address }
      .drive(onNext: { self.infoMarkerWindow?.addressLabel.text = $0 })
      .disposed(by: disposeBag)


  }
}

extension AddressSearchViewController {

  var cameraUpdate: Binder<LocationResponse> {
    return Binder(self) { (vc, response) in
      if let location = response.location {
        GMSGeocoder().reverseGeocodeCoordinate(location.coordinate) { (response, error) in
          if let address = response,
            let result = address.firstResult(),
            let line = result.lines?.first {
            self.addressLabel.text = line
          }
        }
        vc.mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 16.0)
      }
    }
  }

  var locationUpdate: Binder<GeocoderResult> {
    return Binder(self) { (vc, geocoder) in
      if let location = geocoder.geometry?.location {
        let coordinate = CLLocationCoordinate2DMake(location.lat, location.lng)
        self.mapView.animate(toLocation: coordinate)
        self.marker.position = coordinate
        self.addressLabel.text = geocoder.address
        self.marker.appearAnimation = GMSMarkerAnimation.pop
        self.marker.map = self.mapView
      }
    }
  }
}

//MARK: - GMSMapView Delegate
extension AddressSearchViewController: GMSMapViewDelegate {

  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    dismissKeyboard()
    infoMarkerWindow?.removeFromSuperview()
  }
}

//MARK: - Methods
extension AddressSearchViewController {
  func locationError(location: CLLocation?, error: LocationError?) -> Bool {
    guard error == nil else {
      switch error {
      case .authorizationDenied:
        App.toast.error(message: "원활한 서비스를 위해\n위치서비스를 활성화 시켜주세요.\n\n* 설정 -> Grouping앱 -> 위치 활성화",
                        sender: self, location: .top)
      default:
        App.toast.error(message: "지도 업데이트 에러", sender: self, location: .top)
      }
      return false
    }
    return true
  }
}
