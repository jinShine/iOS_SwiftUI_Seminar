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

class HomeViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {}

  //MARK: - UI Properties
  let naviBaseView: UIImageView = {
    let view = UIImageView()
    view.image = UIImage(named: "Navi_Base")
    view.contentMode = .scaleAspectFill
    return view
  }()

  let searchButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "Search"), for: .normal)
    button.setImage(UIImage(named: "Search"), for: .highlighted)
    button.contentMode = .scaleAspectFill
    return button
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



  //MARK: - Properties
  typealias ViewModel = HomeViewModel
  var disposeBag = DisposeBag()


  //MARK: - Initialization
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
extension HomeViewController {

  //INPUT
  func command(viewModel: ViewModel) {


  }


  //OUTPUT
  func state(viewModel: ViewModel) {

    viewModel.state
      .drive(onNext: { [weak self] state in
        guard let self = self else { return }


      })
      .disposed(by: self.disposeBag)
  }

}


//MARK: - Method Handler
extension HomeViewController {

  private func setupUI() {
    self.navigationController?.setNavigationBarHidden(true, animated: false)
    
    [naviBaseView, searchButton].forEach {
      view.addSubview($0)
    }

    setupNavigationBar(at: self.view, leftItem: drawerButton, rightItem: settingButton)

  }

  private func setupConstraint() {

    naviBaseView.snp.makeConstraints {
      $0.top.leading.trailing.equalToSuperview()
      $0.height.equalTo(100)
    }

    searchButton.snp.makeConstraints {
      $0.top.equalTo(naviBaseView.snp.bottom).offset(30)
      $0.leading.equalToSuperview().offset(16)
      $0.trailing.equalToSuperview().offset(-16)
    }

  }

}
