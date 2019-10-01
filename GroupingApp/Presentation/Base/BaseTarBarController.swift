//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()

  }

  private func setupUI() {
//    tabBar.isTranslucent = true
    tabBar.backgroundColor = .blue
  }

}
