//
//  AddressCellViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

struct AddressCellViewModel {
  
  var name: String
  var roadAddress: String?
  var jibunAddress: String?
  var x: String
  var y: String
  var distance: Double
  
  
  init(item: PlaceModel) {

    self.name = item.name

    if let road = item.roadAddress {
      if road != "" {
        self.roadAddress = "[도로명] " + road
      } else {
        self.roadAddress = ""
      }
    }

    if let jibun = item.jibunAddress {
      if jibun != "" {
        self.jibunAddress = "[지번] " + jibun
      } else {
        self.jibunAddress = ""
      }
    }

    self.x = item.x
    self.y = item.y
    self.distance = item.distance
  }
}
