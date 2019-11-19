//
//  UIDevice+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 07/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension UIDevice {

  // Notch check
  var hasNotch: Bool {
    return App.window?.safeAreaInsets.bottom ?? 0 > 0
  }

  var isIPhoneSE: Bool {
    (userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 568) ? true : false
  }

  var isIPhone8: Bool {
    (userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 667) ? true : false
  }

  var isIPhonePlus: Bool {
    (userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 736) ? true : false
  }

  var isIPhoneX: Bool {
    (userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 812) ? true : false
  }

  var isIPhoneXMax: Bool {
    (userInterfaceIdiom == .phone && UIScreen.main.bounds.size.height == 812) ? true : false
  }

}
