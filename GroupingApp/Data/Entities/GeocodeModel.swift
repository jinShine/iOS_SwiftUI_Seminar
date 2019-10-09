//
//  AddressModel.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct Geocode: Codable {
  var addresses: [Addresses]
  
  init() {
    addresses = []
  }
}

struct Addresses: Codable {

  var jibunAddress: String
  var roadAddress: String?
  var x: String
  var y: String
  var distance: Double
  
  enum CodingKeys: String, CodingKey {
    case jibunAddress
    case roadAddress
    case x, y, distance
  }

  init() {
    roadAddress = ""
    jibunAddress = ""
    x = ""
    y = ""
    distance = 0.0
  }
}
