//
//  HomeViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

class HomeViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {

  }


  //MARK: - UI Properties




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
    print("Home ViewController")
  }


}

//MARK: - Bind
extension HomeViewController {

  //OUTPUT
  func command(viewModel: ViewModel) {


  }


  //INPUT
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
  }

}
