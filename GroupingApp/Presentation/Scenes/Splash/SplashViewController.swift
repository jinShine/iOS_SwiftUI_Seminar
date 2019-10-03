//
//  SplashViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

  var splashNavigator: SplashNavigator?


  override func viewDidLoad() {
    super.viewDidLoad()

    self.view.backgroundColor = .red
    setupNavigator()
    
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.splashNavigator?.navigate(to: .home)
    }

  }

  private func setupNavigator() {
    splashNavigator = SplashNavigator(with: self.navigationController)
  }

}
