//
//  SplashViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController, ViewType {
  
  //MARK: - Constant
  struct UI {
    static let logoSize: CGFloat = 96
  }
  
  //MARK: - UI Properties
  
  let logoImageView: UIImageView = {
    let imgView = UIImageView(image: UIImage(named: "Logo"))
    imgView.contentMode = .scaleAspectFit
    return imgView
  }()
  
  
  //MARK: - Properties
  var viewModel: SplashViewModel!

  
  //MARK: - Setup UI
  func setupUI() {
    view.backgroundColor = .white
    view.addSubview(logoImageView)
  }
  
  
  //MARK: - Setup Constraints
  func setupConstraints() {
    logoImageView.snp.makeConstraints {
      $0.center.equalToSuperview()
      $0.size.equalTo(UI.logoSize)
    }
  }
  
  //MARK: - Bind
  func bindViewModel() {
    
    //INPUT
    let showUserInfoListAction = rx.viewDidAppear.mapToVoid()
      .asDriver(onErrorJustReturn: ())
    
    let input = SplashViewModel.Input(showUserInfoListAction: showUserInfoListAction)
    
    //OUTPUT
    let output = viewModel.transform(input: input)
    
    output.showUserInfoListState
      .drive()
      .disposed(by: rx.disposeBag)
  }
}
