//
//  AddressSeachViewController.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

class AddressSearchViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {
    
  }


  //MARK: - UI Properties

  let naviBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "Navi_Base_Rect")
    view.isUserInteractionEnabled = true
    view.contentMode = .scaleToFill
    return view
  }()
  
  let popButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon-Arrow-Left"), for: .normal)
    button.imageView?.tintColor = .black
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let searchBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "SearchBar")
    view.isUserInteractionEnabled = true
    return view
  }()
  
  let searchTextField: UITextField = {
    let searchBar = UITextField()
    searchBar.placeholder = "주소 검색"
    searchBar.clearButtonMode = .whileEditing
    return searchBar
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: String(describing: AddressCell.self))
    return tableView
  }()



  //MARK: - Properties
  typealias ViewModel = AddressSearchViewModel
  var disposeBag = DisposeBag()
  
  
  var addressList: [ItemModel] = []
  let obDidSearch = PublishSubject<String>()

  init(viewModel: ViewModel) {
    defer {
      self.viewModel = viewModel
    }
    super.init()

  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

  }

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupConstraint()

  }
}

//MARK: - Bind
extension AddressSearchViewController {

  //OUTPUT
  func command(viewModel: ViewModel) {

    let obDidTapPop = popButton.rx.tap
    .map { ViewModel.Command.didTapPop }

    let dd = self.obDidSearch.map { ViewModel.Command.didSearch(address: $0) }
 
    Observable<ViewModel.Command>.merge([
      obDidTapPop,
      dd
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
        case .didTapPopState:
          self.navigationController?.popViewController(animated: true)
          
        case .didSearchState(let addressModel):
          self.addressList = addressModel.items
          
        }
      })
      .disposed(by: self.disposeBag)
  }

}


//MARK: - Method Handler
extension AddressSearchViewController {

  private func setupUI() {
    navigationController?.isNavigationBarHidden = true
    tableView.delegate = self
    tableView.dataSource = self
    searchTextField.delegate = self
    
    [naviBaseView, tableView].forEach { view.addSubview($0) }
    [searchBaseView, searchTextField].forEach { naviBaseView.addSubview($0) }
    setupNavigationBar(at: view, leftItem: popButton)
    
  }

  private func setupConstraint() {
    
    naviBaseView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(190)
    }
    
    searchBaseView.snp.makeConstraints {
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
      $0.bottom.equalToSuperview().offset(-4)
    }
    
    searchTextField.snp.makeConstraints {
      $0.centerY.equalTo(searchBaseView).offset(-2)
      $0.leading.equalToSuperview().offset(80)
      $0.trailing.equalToSuperview().offset(-32)
      $0.height.equalTo(46)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(naviBaseView.snp.bottom)
      $0.leading.trailing.bottom.equalToSuperview()
    }
    
  }

}

//MARK: - UITableView Datasource
extension AddressSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addressList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let addressCell = tableView.dequeueReusableCell(withIdentifier: String(describing: AddressCell.self), for: indexPath) as? AddressCell else { return UITableViewCell() }
    addressCell.titleLabel.text = addressList[indexPath.row].title
    addressCell.addressLabel.text = addressList[indexPath.row].address
    addressCell.roadAddressLabel.text = addressList[indexPath.row].roadAddress
    return addressCell
  }
}

//MARK: - UITableView Delegate
extension AddressSearchViewController: UITableViewDelegate {
  
}

//MARK: - UITextField Delegate
extension AddressSearchViewController: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    
    self.obDidSearch.onNext(textField.text ?? "")
//
//      useC.requestAddress(address: textField.text ?? "")
//        .subscribe(onNext: { (addressModel) in
//          print("AddressModel", addressModel)
//        })
//        .disposed(by: self.disposeBag)

      return true
  }
  
}

