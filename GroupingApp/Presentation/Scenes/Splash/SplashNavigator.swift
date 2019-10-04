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
        makeHomeViewController(),
        makeRegistryViewController(),
        makeSearchViewController()
      ]

      presenter?.pushViewController(tabBarController, animated: true)
    }
  }

  private func makeHomeViewController() -> UIViewController {
    let homeViewModel = HomeViewModel()
    let homeVC = HomeViewController(viewModel: homeViewModel)
    return UINavigationController.generate(rootViewController: homeVC,
                                           image: UIImage(named: "TabBar_Home")?.withRenderingMode(.alwaysOriginal),
                                           selectedImage: UIImage(named: "TabBar_Home_Selected")?.withRenderingMode(.alwaysOriginal))
  }

  private func makeRegistryViewController() -> UIViewController {
    return UINavigationController.generate(image: UIImage(named: "TabBar_Registry")?.withRenderingMode(.alwaysOriginal),
                                           selectedImage: UIImage(named: "TabBar_Registry_Selected")?.withRenderingMode(.alwaysOriginal))
  }

  private func makeSearchViewController() -> UIViewController {
    let searchViewModel = SearchViewModel()
    let searchVC = SearchViewController(viewModel: searchViewModel)
    return UINavigationController.generate(rootViewController: searchVC,
                                    image: UIImage(named: "TabBar_Search")?.withRenderingMode(.alwaysOriginal),
                                    selectedImage: UIImage(named: "TabBar_Search_Selected")?.withRenderingMode(.alwaysOriginal))
  }

}
