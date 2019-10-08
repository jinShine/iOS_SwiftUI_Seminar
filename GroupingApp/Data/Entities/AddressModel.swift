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
  var roadAddress: String?
  var jibunAddress: String?
  var x: String
  var y: String
  var distance: Double
  
  enum CodingKeys: String, CodingKey {
    case name
    case roadAddress = "road_address"
    case jibunAddress = "jibun_address"
    case x, y, distance
  }

  init() {
    name = ""
    roadAddress = ""
    jibunAddress = ""
    x = ""
    y = ""
    distance = 0.0
  }
}
