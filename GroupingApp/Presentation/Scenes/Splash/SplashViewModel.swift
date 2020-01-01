//
//  SplashViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2020/01/01.
//  Copyright © 2020 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class SplashViewModel: ViewModelType {
  
  struct Input {
    let showUserInfoListAction: Driver<Void>
  }
  
  struct Output {
    let showUserInfoListState: Driver<Void>
  }
  
  
  //MARK: - Properties
  private var navigator: SplashNavigator
  
  
  //MARK: - Initialize
  init(navigator: SplashNavigator) {
    self.navigator = navigator
  }
  
  
  func transform(input: Input) -> Output {
    
    let showUserInfoListState = input.showUserInfoListAction
      .delay(1.0)
      .map { self.navigator.navigate(to: .userInfoList) }
    
    return Output(showUserInfoListState: showUserInfoListState)
  }
  
}
