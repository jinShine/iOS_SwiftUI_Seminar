//
//  AddressCellViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct AddressCellViewModel {
  
  var name: String
  var road_address: String?
  var jibun_address: String?
  var x: String
  var y: String
  var distance: Double
  
  
  init(item: PlaceModel) {
    self.name = item.name
    self.road_address = item.road_address
    self.jibun_address = item.jibun_address
    self.x = item.x
    self.y = item.y
    self.distance = item.distance
  }
  
}
