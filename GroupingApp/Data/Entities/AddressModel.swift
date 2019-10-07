//
//  AddressModel.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct AddressModel: Codable {
  var places: [PlaceModel]
  
  init() {
    places = []
  }
}

struct PlaceModel: Codable {
  var name: String
  var road_address: String?
  var jibun_address: String?
  var x: String
  var y: String
  var distance: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case road_address = "roadAddress"
    case jibun_address = "jibunAddress"
    case x, y, distance
  }

  init() {
    name = ""
    road_address = ""
    jibun_address = ""
    x = ""
    y = ""
    distance = 0.0
  }
}
