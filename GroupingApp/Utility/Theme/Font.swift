//
//  Font.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

struct Font {
  
  func regular(size: CGFloat) -> UIFont {
    if UIDevice.current.isIPhoneSE {
      return UIFont.systemFont(ofSize: size - 2)
    } else if UIDevice.current.isIPhone8 {
      return UIFont.systemFont(ofSize: size - 1)
    } else {
      return UIFont.systemFont(ofSize: size)
    }
  }
  
  func bold(size: CGFloat) -> UIFont {
    if UIDevice.current.isIPhoneSE {
      return UIFont.boldSystemFont(ofSize: size - 2)
    } else if UIDevice.current.isIPhone8 {
      return UIFont.boldSystemFont(ofSize: size - 1)
    } else {
      return UIFont.boldSystemFont(ofSize: size)
    }
  }
  
}

