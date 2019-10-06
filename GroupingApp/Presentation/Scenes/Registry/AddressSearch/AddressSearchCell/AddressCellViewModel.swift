//
//  AddressCellViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct AddressCellViewModel {
  
  var title: String
  var address: String?
  var roadAddress: String?
  var mapx: String
  var mapy: String
  
  
  init(item: ItemModel) {
    self.title = item.title
    self.address = item.address
    self.roadAddress = item.roadAddress
    self.mapx = item.mapx
    self.mapy = item.mapy
  }
  
}
