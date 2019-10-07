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

extension UIView {
  
  static var resuseIdentifier: String {
    let nameSpaceClassName = NSStringFromClass(self)
    guard let className = nameSpaceClassName.components(separatedBy: ".").last else {
      return nameSpaceClassName
    }
    return className
  }
  
  class func newFromNib() -> UIView? {
    guard let view = Bundle.main.loadNibNamed(self.resuseIdentifier, owner: nil, options: nil)?.first as? UIView else {
      return nil
    }
    return view
  }
  
  class func nib() -> UINib {
    return UINib(nibName: self.resuseIdentifier, bundle: nil)
  }
  
}
