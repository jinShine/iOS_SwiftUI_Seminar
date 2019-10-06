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




  //MARK: - Properties
  typealias ViewModel = SelectMapViewModel
  var disposeBag = DisposeBag()
  
  let selectedItem: ItemModel


  init(viewModel: ViewModel, selectedItem: ItemModel) {
    defer {
      self.viewModel = viewModel
    }
    self.selectedItem = selectedItem

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

    print(selectedItem)
  }
}

//MARK: - Bind
extension SelectMapViewController {

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
extension SelectMapViewController {

  private func setupUI() {

  }

  private func setupConstraint() {

  }

}

