//
//  SearchViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

class SearchViewController: BaseViewController, BindViewType {

  //MARK: - Constant
  struct Constant {

  }


  //MARK: - UI Properties




  //MARK: - Properties
  typealias ViewModel = SearchViewModel
  var disposeBag = DisposeBag()
  //  var dataSource: RxTableViewSectionedReloadDataSource<SectionOfUserModel>?


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
extension SearchViewController {

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
extension SearchViewController {

  private func setupUI() {

  }

  private func setupConstraint() {

  }

}
