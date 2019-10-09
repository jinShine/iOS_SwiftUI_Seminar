//
//  AddressCellViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

struct AddressCellViewModel {
  
  var jibunAddress: String
  var roadAddress: String?
  var x: String
  var y: String
  var distance: Double
  
  
  init(item: Addresses) {
    
    self.jibunAddress = item.jibunAddress

    if let road = item.roadAddress {
      if road != "" {
        self.roadAddress = "[도로명] " + road
      } else {
        self.roadAddress = ""
      }
    }

    self.x = item.x
    self.y = item.y
    self.distance = item.distance
  }
}
