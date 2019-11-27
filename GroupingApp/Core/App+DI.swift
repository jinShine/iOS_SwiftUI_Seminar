//
//  App+DI.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/27.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension App {
  
  func setupRoot(with window: UIWindow) {
    splashNavigator(in: window)
    
  }
  
  private func splashNavigator(in window: UIWindow) {
    let navigationController = UINavigationController()
    let splashNavigator = SplashNavigator(in: window, with: navigationController)
    splashNavigator.navigate(to: .home)
  }

}
