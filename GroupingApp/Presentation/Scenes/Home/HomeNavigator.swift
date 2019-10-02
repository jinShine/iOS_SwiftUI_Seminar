//
//  HomeNavigator.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import FlowInject

//enum HomeRoute: Route {
//  case home
//}
//
//class HomeNavigator: Navigator<HomeRoute> {
//
//  func navigate(to destination: SplashRoute) {
//    switch destination {
//    case .home:
//      let tabBarController = BaseTabBarController()
//      tabBarController.viewControllers = [
//        setupHome()
//      ]
//
//      presenter?.pushViewController(tabBarController, animated: true)
//    }
//  }
//
//  private func setupHome() -> UIViewController {
//    let homeViewModel = HomeViewModel()
//    let homeVC = HomeViewController(viewModel: homeViewModel)
//    let navigationController = UINavigationController(rootViewController: homeVC)
//    navigationController.tabBarItem.image = UIImage(named: "TabBar_Home")?.withRenderingMode(.alwaysTemplate)
//    navigationController.tabBarItem.selectedImage = UIImage(named: "TabBar_Home_Selected")?.withRenderingMode(.alwaysTemplate)
//    return navigationController
//  }
//}
