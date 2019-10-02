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
      tabBarController.viewControllers = [
        setupHome(),
        setupRegistry(),
        setupSearch()
      ]

      presenter?.pushViewController(tabBarController, animated: true)
    }
  }

  private func setupHome() -> UIViewController {
    let homeViewModel = HomeViewModel()
    let homeVC = HomeViewController(viewModel: homeViewModel)
    let navigationController = BaseNavigationController(rootViewController: homeVC)
    navigationController.tabBarItem.image = UIImage(named: "TabBar_Home")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.selectedImage = UIImage(named: "TabBar_Home_Selected")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    return navigationController
  }

  private func setupRegistry() -> UIViewController {
    let registryViewModel = RegistryViewModel()
    let registryVC = RegistryViewController(viewModel: registryViewModel)
    let navigationController = BaseNavigationController(rootViewController: registryVC)
    navigationController.tabBarItem.image = UIImage(named: "TabBar_Registry")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.selectedImage = UIImage(named: "TabBar_Registry_Selected")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    return navigationController
  }

  private func setupSearch() -> UIViewController {
    let searchViewModel = SearchViewModel()
    let searchVC = SearchViewController(viewModel: searchViewModel)
    let navigationController = BaseNavigationController(rootViewController: searchVC)
    navigationController.tabBarItem.image = UIImage(named: "TabBar_Search")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.selectedImage = UIImage(named: "TabBar_Search_Selected")?.withRenderingMode(.alwaysOriginal)
    navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    return navigationController
  }

}
