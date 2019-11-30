//
//  HomeViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import SnapKit

class UserInfoListViewController: BaseViewController, ViewType {

  //MARK: - Constant
  struct Constant {}

  //MARK: - UI Properties
  let naviBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "Navi_Base")
    view.contentMode = .scaleAspectFill
    return view
  }()
  
  let drawerButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon-Menu"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  let settingButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Icon-Menu"), for: .normal)
    button.contentMode = .scaleAspectFit
    return button
  }()
  
  lazy var searchBar: SJSearchBar = {
    let searchBar = SJSearchBar()
    searchBar.textField.placeholder = "검색"
    searchBar.textField.returnKeyType = .search
    searchBar.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4)
    return searchBar
  }()
  
  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.backgroundColor = .clear
    tableView.separatorStyle = .none
    tableView.rowHeight = UITableView.automaticDimension
    tableView.estimatedRowHeight = 150
    tableView.register(UserInfoListCell.nib(), forCellReuseIdentifier: UserInfoListCell.reuseIdentifier)
    return tableView
  }()
  

  //MARK: - Properties
  var viewModel: UserInfoListViewModel!
  
  var list = BehaviorSubject<[String]>(value: [
    "1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1","1"
  ])
  

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  //MARK: - Setup UI
  func setupUI() {
    
    [naviBaseView, searchBar, tableView].forEach {
      view.addSubview($0)
    }

    setupNavigationBar(at: self.view, leftItem: drawerButton, rightItem: settingButton)
  }
  
  //MARK: - Setup Constraints
  func setupConstraints() {
    naviBaseView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(100)
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
    
    tableView.snp.makeConstraints {
      $0.top.equalTo(searchBar.snp.bottom).offset(16)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.bottom.equalToSuperview().offset(-16)
    }

  }
  
  //MARK: - Bind
  func bindViewModel() {
    
    //INPUT
    let userInfoListAction = rx.viewWillAppear.mapToVoid()
    
    let input = UserInfoListViewModel.Input(userInfoListAction: userInfoListAction)
    
    //OUTPUT
    let output = viewModel.transform(input: input)
    
    output.userInfoListState
      .bind(to: tableView.rx.items(dataSource: viewModel.datasource))
      .disposed(by: rx.disposeBag)
  }

}
