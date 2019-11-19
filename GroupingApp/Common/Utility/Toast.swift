//
//  Toast.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/19.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import Loaf

final class Toast {
  
  func error(message: String,
             sender: UIViewController,
             location: Loaf.Location = Loaf.Location.bottom) {
    Loaf(message, state: .error, location: location, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func info(message: String,
             sender: UIViewController,
             location: Loaf.Location = Loaf.Location.bottom) {
    Loaf(message, state: .info, location: location, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func success(message: String,
             sender: UIViewController,
             location: Loaf.Location = Loaf.Location.bottom) {
    Loaf(message, state: .success, location: location, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func warning(message: String,
             sender: UIViewController,
             location: Loaf.Location = Loaf.Location.bottom) {
    Loaf(message, state: .warning, location: location, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
}
