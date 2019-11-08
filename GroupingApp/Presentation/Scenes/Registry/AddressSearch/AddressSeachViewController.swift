//
//  AddressSeachViewController.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import RxOptional
import GoogleMaps

class AddressSearchViewController: BaseViewController, ViewType {
  
  //MARK: - Constant
  
  //MARK: - UI Properties
  lazy var mapView: GMSMapView = {
    let mapView = GMSMapView()
    mapView.padding = UIEdgeInsets(top: UIDevice.current.hasNotch ? 88 : 44, left: 0, bottom: 0, right: 0)
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

  let saveAddressButton: SJButton = {
    let button = SJButton(title: "선택한 위치로 설정", image: UIImage(named: "Icon_Checkmark"))
    button.setBackgroundImage(UIImage(named: "Button_Background_Flat"), for: .normal)
    return button
  }()

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
    [addressLabel, addressDetailField, saveAddressButton].forEach {
      addressContainer.addSubview($0)
    }
    
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
      if UIDevice.current.isIPhoneSE || UIDevice.current.isIPhone8 {
        $0.height.equalTo(46)
      } else {
        $0.height.equalTo(56)
      }
    }

    addressContainer.snp.makeConstraints {
      $0.leading.trailing.equalToSuperview()
      $0.bottom.equalToSuperview().offset(-(App.window?.safeAreaInsets.bottom ?? 0))
    }
    
    addressLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      if UIDevice.current.isIPhoneSE || UIDevice.current.isIPhone8 {
        $0.height.equalTo(22)
      } else {
        $0.height.equalTo(32)
      }
    }
    
    addressDetailField.snp.makeConstraints {
      $0.top.equalTo(addressLabel.snp.bottom)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      if UIDevice.current.isIPhoneSE || UIDevice.current.isIPhone8 {
        $0.height.equalTo(22)
      } else {
        $0.height.equalTo(32)
      }
    }
    
    saveAddressButton.snp.makeConstraints {
      $0.top.equalTo(addressDetailField.snp.bottom).offset(8)
      $0.leading.trailing.equalToSuperview()
      if UIDevice.current.isIPhoneSE || UIDevice.current.isIPhone8 {
        $0.height.equalTo(50)
      } else {
        $0.height.equalTo(56)
      }
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

    let saveAddress = saveAddressButton.rx.tap
      .map { self.addressLabel.text ?? "" }
      .map { $0 + " " + (self.addressDetailField.text ?? "") }

    let input = AddressSearchViewModel.Input(didTapPopButton: didTapPopButton,
                                             locationStart: locatoinStart,
                                             locationFetch: locationFetch,
                                             didSearch: didSearch,
                                             keyboardWillShowTrigger: keyboardWillShow,
                                             keyboardWillHideTrigger: keyboardWillHide,
                                             saveAddress: saveAddress)

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
      .drive(onNext: { [weak self] (location, _) in
        guard let self = self else { return }

        self.viewModel.reverseGeocodeCoordinate(geocoder: GMSGeocoder(),
                                                 location: location,
                                                 completion: { self.addressLabel.text = $0 })
        self.mapView.camera = GMSCameraPosition(
          target: location?.coordinate ?? self.viewModel.defaultCoordinate,
          zoom: 16.0
        )
      })
      .disposed(by: disposeBag)

    let searchedShared = output.searchedGeocoder
      .asSharedSequence()

    searchedShared
      .filter { $0.address == "" && $0.geometry == nil }
      .drive(onNext: { _ in
        App.toast.info(message: "주소 결과가 없습니다.\n정확한 주소로 검색해주세요.", sender: self, location: .top)
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
          self.addressContainer.layoutIfNeeded()
        }
      })
    .disposed(by: disposeBag)

    output.keyboardDidHide
      .drive(onNext: { _ in
        self.addressContainer.snp.updateConstraints {
          $0.bottom.equalToSuperview().offset(-(App.window?.safeAreaInsets.bottom ?? 0))
        }
        UIView.animate(withDuration: 0.35) {
          self.addressContainer.layoutIfNeeded()
        }
      })
      .disposed(by: disposeBag)
    
    output.toRegistryAfterSave
    .drive()
    .disposed(by: disposeBag)
  }
}

//MARK: - Methods
extension AddressSearchViewController {

  var locationUpdate: Binder<GeocoderResult> {
    return Binder(self) { (vc, geocoder) in
      if let location = geocoder.geometry?.location {
        let coordinate = CLLocationCoordinate2DMake(location.lat, location.lng)
        self.mapView.animate(toLocation: coordinate)
        self.marker.position = coordinate
        self.addressLabel.text = geocoder.address.removalRepublicKorea()
        self.marker.appearAnimation = GMSMarkerAnimation.pop
        self.marker.map = self.mapView
      }
    }
  }

  func locationError(location: CLLocation?, error: LocationError?) -> Bool {
    guard error == nil else {
      saveAddressButton.inActivate()

      switch error {
      case .authorizationDenied:
        App.toast.error(message: "원활한 서비스를 위해\n위치서비스를 활성화 시켜주세요.\n\n* 설정 -> Grouping앱 -> 위치 활성화", sender: self, location: .top)
      default:
        App.toast.error(message: "지도 업데이트 에러", sender: self, location: .top)
      }
      return false
    }

    saveAddressButton.activate()
    return true
  }

}

//MARK: - GMSMapView Delegate
extension AddressSearchViewController: GMSMapViewDelegate {

  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    dismissKeyboard()
  }
}

