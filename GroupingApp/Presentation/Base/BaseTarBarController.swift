//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import SnapKit

class BaseTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
  }

  private func setupUI() {
    tabBar.isTranslucent = true
    tabBar.barTintColor = .white
    tabBar.layer.cornerRadius = 10
    tabBar.layer.masksToBounds = true
    tabBar.layer.shadowOffset = CGSize.zero
    tabBar.layer.shadowRadius = 2
    tabBar.layer.shadowColor = UIColor.black.cgColor
    tabBar.layer.shadowOpacity = 0.16
  }

}

extension UITabBar {

  private struct Constant {
    static let tabBarHeight: CGFloat = 70
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    super.sizeThatFits(size)
    let tabBarHeight: CGFloat = Constant.tabBarHeight

    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = tabBarHeight

    return sizeThatFits
  }
}
