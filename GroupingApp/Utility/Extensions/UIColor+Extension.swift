//
//  UIColor+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

//MARK: - UIColor
extension UIColor {
  convenience init(hex: String) {
    let hexStr: NSString = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased() as NSString
    let scan = Scanner(string: hexStr as String)

    if hexStr.hasPrefix("#") {
      scan.scanLocation = 1
    }

    var color: UInt32 = 0
    scan.scanHexInt32(&color)

    let mask = 0x000000FF
    let r = Int(color >> 16) & mask
    let g = Int(color >> 8) & mask
    let b = Int(color) & mask

    let red   = CGFloat(r) / 255.0
    let green = CGFloat(g) / 255.0
    let blue  = CGFloat(b) / 255.0

    self.init(red: red, green: green, blue: blue, alpha: 1)
  }

  func toHexStr() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    getRed(&r, green: &g, blue: &b, alpha: &a)

    let rgb: Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0

    return NSString(format: "#%06x", rgb) as String
  }

  convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat? = nil) {
    self.init(red: r / 255, green: g / 255, blue: b / 255, alpha: a ?? 255 / 255)
  }
}
