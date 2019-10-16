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

class AddressSearchViewController: BaseViewController, BindViewType {
  
  //MARK: - Constant
  struct Constant {
    
  }
  
  
  //MARK: - UI Properties
  
  lazy var mapView: GMSMapView = {
    let mapView = GMSMapView()
    mapView.settings.consumesGesturesInView = false
    mapView.delegate = self
    return mapView
  }()
  
  let popButton: UIButton = {
    let button = UIButton()
    let image = UIImage(named: "Icon_Round_Left")
    button.setImage(image, for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let searchBaseView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "Search_Base")
    imageView.image = image
    imageView.contentMode = .scaleAspectFill
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  lazy var searchTextField: UITextField = {
    let searchBar = UITextField()
    searchBar.placeholder = "주소 검색"
    searchBar.clearButtonMode = .whileEditing
    return searchBar
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.keyboardDismissMode = .onDrag
    tableView.backgroundColor = .white
    tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    tableView.register(AddressCell.nib(), forCellReuseIdentifier: AddressCell.reuseIdentifier)
    return tableView
  }()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  //MARK: - Properties
  typealias ViewModel = AddressSearchViewModel
  var disposeBag = DisposeBag()
  let navigator: AddressSearchNavigator
  var datasource: RxTableViewSectionedReloadDataSource<SearchSection>?
  
  //MARK: - Inintialize
  init(viewModel: ViewModel, navigator: AddressSearchNavigator) {
    defer {
      self.viewModel = viewModel
    }
    self.navigator = navigator
    
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
    searchTextField.becomeFirstResponder()
  }
  
}

//MARK: - Bind
extension AddressSearchViewController {
  
  //OUTPUT
  func command(viewModel: ViewModel) {
    
    let obLocationStart = rx.viewDidLoad.map {
      ViewModel.Command.locationStart
    }
    
    let obLocationFetch = rx.viewDidLoad.map {
      ViewModel.Command.locationFetch
    }
    
    let obLocationStop = rx.viewDidDisappear.map { _ in
      ViewModel.Command.locationStop
    }
    
    let obDidTapPop = popButton.rx.tap
      .map { ViewModel.Command.didTapPop }
    
    let obDidSearchText = searchTextField.rx.text.asObservable()
      .distinctUntilChanged()
      .map { ViewModel.Command.didSearch(address: $0 ?? "") }
    
    let obDidCellSelected = tableView.rx.itemSelected
      .map { ViewModel.Command.didTapCell(indexPath: $0)}
    
    Observable<ViewModel.Command>.merge([
      obLocationStart,
      obLocationStop,
      obLocationFetch,
      obDidTapPop,
      obDidSearchText,
      obDidCellSelected
    ])
      .bind(to: viewModel.command)
      .disposed(by: disposeBag)
    
  }
  
  
  //INPUT
  func state(viewModel: ViewModel) {
    
    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }
        
        switch state {
        case .locationStartState: return
        case .locationStopState: return
        case .locationFetchState(let locationResonse):
          let lat = locationResonse.0?.coordinate.latitude ?? 0.0
          let lon = locationResonse.0?.coordinate.longitude ?? 0.0
          self.mapView.camera = GMSCameraPosition(latitude: lat, longitude: lon, zoom: 17.0)
        case .didTapPopState:
          self.navigationController?.popViewController(animated: true)
          
        case .didSearchState(let cellViewModel):
          print("View Model", cellViewModel)
          self.tableView.delegate = nil
          self.tableView.dataSource = nil
          self.datasource = RxTableViewSectionedReloadDataSource<SearchSection> (
            configureCell: { ( datasource, tableView, indexPath, item) -> UITableViewCell in
              switch item {
              case .addressItem(let viewmodel):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.reuseIdentifier) as? AddressCell else {
                  return UITableViewCell()
                }
                print("View Model", viewmodel)
                cell.viewModel = viewmodel
                return cell
              }
          })
          Observable.just(cellViewModel)
            .bind(to: self.tableView.rx.items(dataSource: self.datasource!))
            .disposed(by: self.disposeBag)
          
        case .didTapCellState(let placeItem):
          log.debug("Place", placeItem)
//          self.navigator.navigate(to: .selectMap(placeItem))
        }
      })
      .disposed(by: self.disposeBag)
    
  }
  
}


//MARK: - Method Handler
extension AddressSearchViewController {
  
  private func setupUI() {
    
    view.insertSubview(mapView, at: 0)
    
    [searchBaseView].forEach {
      mapView.addSubview($0)
    }
    
    [searchTextField].forEach {
      searchBaseView.addSubview($0)
    }
    
    setupNavigationBar(at: view, leftItem: popButton)
    navigationBaseView.backgroundColor = .clear
  }
  
  private func setupConstraint() {
    
    mapView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }

    searchBaseView.snp.makeConstraints {
      $0.top.equalTo(navigationBaseView.snp.bottom).offset(32)
      $0.leading.equalToSuperview().offset(32)
      $0.trailing.equalToSuperview().offset(-32)
    }

    searchTextField.snp.makeConstraints {
      $0.centerY.equalToSuperview().offset(-4)
      $0.leading.equalToSuperview().offset(36)
      $0.trailing.equalToSuperview().offset(-8)
    }
    
  }
}

//MARK: - GMSMapView Delegate
extension AddressSearchViewController: GMSMapViewDelegate {

  func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    dismissKeyboard()
  }
  
  func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
    dismissKeyboard()
  }
}


extension AddressSearchViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    
    return true
  }
}
