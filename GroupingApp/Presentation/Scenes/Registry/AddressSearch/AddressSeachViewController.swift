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

  let popButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon-Arrow-Left"), for: .normal)
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
  
  let searchBaseView: UIView = {
    let view = UIView()
    view.backgroundColor = .white
    return view
  }()
  
  let searchIcon: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(named: "Icon-Search")
    return imageView
  }()
  
  let searchTextField: UITextField = {
    let searchBar = UITextField()
    searchBar.placeholder = "주소 검색"
    searchBar.clearButtonMode = .whileEditing
    return searchBar
  }()
  
  let line: UIView = {
    let view = UIView()
    view.backgroundColor = App.color.main
    return view
  }()
  
  let tableView: UITableView = {
    let tableView = UITableView()
    tableView.estimatedRowHeight = 100
    tableView.rowHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
    tableView.keyboardDismissMode = .onDrag
    tableView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: String(describing: AddressCell.self))
    return tableView
  }()

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }

  //MARK: - Properties
  typealias ViewModel = AddressSearchViewModel
  var disposeBag = DisposeBag()
  
  
  var addressList: [ItemModel] = []

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

    let obDidSearchText = searchTextField.rx.text.asObservable()
      .map { ViewModel.Command.didSearch(address: $0 ?? "") }
    
    Observable<ViewModel.Command>.merge([
      obDidTapPop,
      obDidSearchText
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
          
          print(addressModel)
          self.addressList = addressModel.items
          self.tableView.reloadData()
          
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
    tableView.backgroundColor = .white
    tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    
    [searchBaseView, tableView ].forEach { view.addSubview($0) }
    [searchIcon, searchTextField, line].forEach { searchBaseView.addSubview($0) }
    setupNavigationBar(at: view, leftItem: popButton, titleItem: naviTitleLabel)
    navigationBaseView.backgroundColor = .white
  }

  private func setupConstraint() {

    searchBaseView.snp.makeConstraints {
      $0.top.equalTo(navigationBaseView.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(70)
    }
    
    searchIcon.snp.makeConstraints {
      $0.centerY.equalToSuperview().offset(8)
      $0.leading.equalToSuperview().offset(32)
      $0.size.equalTo(18)
    }

    searchTextField.snp.makeConstraints {
      $0.centerY.equalTo(searchBaseView).offset(8)
      $0.leading.equalTo(searchIcon.snp.trailing).offset(14)
      $0.trailing.equalToSuperview().offset(-32)
    }
    
    line.snp.makeConstraints {
      $0.bottom.equalToSuperview()
      $0.leading.equalTo(searchIcon)
      $0.trailing.equalTo(searchTextField)
      $0.height.equalTo(2)
    }
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchBaseView.snp.bottom)
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
    
    addressCell.titleLabel.text = addressList[indexPath.row].title.removeHTMLTags
    
    if let address = addressList[indexPath.row].address {
      if address != "" {
        addressCell.addressLabel.text = "[지번] " + address
      } else {
        addressCell.addressLabel.text = ""
      }
    }
  
    if let roadAddress = addressList[indexPath.row].roadAddress {
      if roadAddress != "" {
          addressCell.roadAddressLabel.text = "[도로명] " + roadAddress
      } else {
        addressCell.roadAddressLabel.text = ""
      }
    }
    
    return addressCell
  }
}

//MARK: - UITableView Delegate
extension AddressSearchViewController: UITableViewDelegate {
  
}

