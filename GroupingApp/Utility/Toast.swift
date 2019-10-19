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
             sender: UIViewController) {
    Loaf(message, state: .error, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func info(message: String,
             sender: UIViewController) {
    Loaf(message, state: .info, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func success(message: String,
             sender: UIViewController) {
    Loaf(message, state: .success, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
  func warning(message: String,
             sender: UIViewController) {
    Loaf(message, state: .warning, location: .bottom, presentingDirection: .vertical, dismissingDirection: .vertical, sender: sender).show()
  }
  
}
