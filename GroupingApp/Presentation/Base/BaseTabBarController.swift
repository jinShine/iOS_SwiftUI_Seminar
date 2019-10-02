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

    tabBarClear()
    tabBar.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: -2, blur: 16)

  }

  func tabBarClear() {
    let appearance = UITabBar.appearance()
    appearance.shadowImage = UIImage()
    appearance.backgroundImage = UIImage()
    appearance.backgroundColor = .white
  }

}

extension UITabBar {

  private struct Constant {
    static let tabBarHeight: CGFloat = 70
  }

  // TabBar Height 조절 방법
  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    super.sizeThatFits(size)
    let tabBarHeight: CGFloat = Constant.tabBarHeight

    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = tabBarHeight

    return sizeThatFits
  }

}

//Sketch 스타일
extension CALayer {
  func applyShadow (
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
  }
}
