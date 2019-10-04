//
//  UIView+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension UIButton {

  func activate() {
    self.isEnabled = true
    self.alpha = 1.0
  }

  func unActivate() {
    self.isEnabled = false
    self.alpha = 0.3
  }

}
