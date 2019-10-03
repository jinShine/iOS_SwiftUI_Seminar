//
//  UINavigationController+Extension.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension UINavigationController {
  
  static func generate (
    rootViewController: UIViewController = UIViewController(),
    image: UIImage?,
    selectedImage: UIImage?
  ) -> UINavigationController {
    let navigationController = BaseNavigationController(rootViewController: rootViewController)
    navigationController.tabBarItem.image = image
    navigationController.tabBarItem.selectedImage = selectedImage
    return navigationController
  }
  
}
