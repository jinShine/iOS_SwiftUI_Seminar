//
//  CALayer+Extension.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/07.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

//MARK: - CALayer
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
