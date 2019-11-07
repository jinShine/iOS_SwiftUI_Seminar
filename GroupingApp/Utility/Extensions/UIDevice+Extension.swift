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

}
