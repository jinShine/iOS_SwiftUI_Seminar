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
    return UIFont.systemFont(ofSize: size)
  }
  
  func bold(size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
  }
  
}

