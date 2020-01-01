//
//  AppNavigator.swift
//  GroupingApp
//
//  Created by seungjin on 2020/01/01.
//  Copyright © 2020 Jinnify. All rights reserved.
//

import Foundation
import FlowInject

enum AppRoute: Route {
  case splash
}

class AppNavigator: Navigator<AppRoute> {
  
  func navigate(to destination: AppRoute) {
    switch destination {
    case .splash:
      let viewModel = SplashViewModel(navigator: SplashNavigator(with: presenter))
      let viewController = SplashViewController.create(with: viewModel)
      presenter?.pushViewController(viewController, animated: false)
    }
  }
}
