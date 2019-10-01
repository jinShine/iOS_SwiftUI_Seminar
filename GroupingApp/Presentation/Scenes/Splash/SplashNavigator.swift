//
//  SplashNavigator.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import FlowInject

enum SplashRoute: Route {
  case home
}

class SplashNavigator: Navigator<SplashRoute> {

  func navigate(to destination: SplashRoute) {
    switch destination {
    case .home:
      let tabBarController = BaseTabBarController()

      let homeVC = HomeViewController()
      homeVC.tabBarItem.title = "홈"

      tabBarController.viewControllers = [
        homeVC
      ]

      presenter?.pushViewController(tabBarController, animated: true)
    }
  }

  private func setupHome() {
    
  }



}
