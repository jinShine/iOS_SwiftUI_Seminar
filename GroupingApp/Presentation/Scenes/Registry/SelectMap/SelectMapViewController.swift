//
//  SelectMapViewController.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

class SelectMapViewController: BaseViewController, BindViewType {
  
  
  //MARK: - Constant
  struct Constant {
    
  }
  
  
  //MARK: - UI Properties
  
  let popButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "Icon-Arrow-Left")
    button.setImage(image, for: .normal)
    button.imageView?.tintColor = .black
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let naviTitleLabel: UILabel = {
    let label = UILabel()
    label.text = "주소 설정"
    label.textColor = .black
    label.textAlignment = .center
    label.font = App.font.bold(size: 18)
    return label
  }()
  
  let jibunAddressLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.textAlignment = .left
    label.font = App.font.bold(size: 18)
    return label
  }()
  
  let roadAddressLabel: UILabel = {
    let label = UILabel()
    label.textColor = App.color.sub
    label.textAlignment = .left
    label.font = App.font.bold(size: 14)
    return label
  }()

//  let mapView: NMFMapView = {
//    let map = NMFMapView()
//    return map
//  }()
//
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  
  //MARK: - Properties
  typealias ViewModel = SelectMapViewModel
  var disposeBag = DisposeBag()
  
  
  init(viewModel: ViewModel) {
    defer {
      self.viewModel = viewModel
    }
    
    super.init()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupConstraint()
    
    
  }
}

//MARK: - Bind
extension SelectMapViewController {
  
  //INPUT
  func command(viewModel: ViewModel) {

//    let obBindPlaceData = rx.viewWillAppear.map { _ in
//      ViewModel.Command.bindPlaceData
//    }
    
    Observable.merge([
//      obBindPlaceData
    ])
    .bind(to: viewModel.command)
    .disposed(by: disposeBag)
    
  }
  
  
  //OUTPUT
  func state(viewModel: ViewModel) {
    
    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }
        
        switch state {
//        case .bindPlaceDataState(let placeInfo):
//          self.jibunAddressLabel.text = placeInfo.jibunAddress
//          self.roadAddressLabel.text = placeInfo.roadAddress
//          let latlng = NMGLatLng(lat: Double(placeInfo.y)!, lng: Double(placeInfo.x)!)
//          let cameraPosition = NMFCameraUpdate(scrollTo: latlng, zoomTo: 17)
//          self.mapView.moveCamera(cameraPosition)
//          let marker = NMFMarker(position: latlng, iconImage: NMFOverlayImage(image: UIImage(named: "Icon_pin") ?? UIImage()))
//          marker.mapView = self.mapView
        }
      })
      .disposed(by: self.disposeBag)
  }
}


//MARK: - Method Handler
extension SelectMapViewController {
  
  private func setupUI() {
    
    setupNavigationBar(at: view, leftItem: popButton, titleItem: naviTitleLabel)

    [jibunAddressLabel, roadAddressLabel].forEach {
      view.addSubview($0)
    }
  }
  
  private func setupConstraint() {
    
    jibunAddressLabel.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(32)
      $0.top.equalTo(navigationBaseView.snp.bottom).offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    roadAddressLabel.snp.makeConstraints {
      $0.top.equalTo(jibunAddressLabel.snp.bottom).offset(4)
      $0.leading.trailing.equalTo(jibunAddressLabel)
    }

//    mapView.snp.makeConstraints {
//      $0.top.equalTo(roadAddressLabel.snp.bottom).offset(32)
//      $0.leading.trailing.bottom.equalToSuperview()
//    }
  }
}

