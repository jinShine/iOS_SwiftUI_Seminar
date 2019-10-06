//
//  BaseNavigationController.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  private func setupUI() {
    navigationBar.isTranslucent = true
  }

}
