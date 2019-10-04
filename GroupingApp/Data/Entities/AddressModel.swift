//
//  AddressModel.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct AddressModel: Codable {
  var items: [ItemModel]
}

struct ItemModel: Codable {
  var title: String
  var address: String?
  var roadAddress: String?
  var mapx: String
  var mapy: String

  init() {
    title = ""
    address = ""
    roadAddress = ""
    mapx = ""
    mapy = ""
  }
}
