//
//  AddressCellViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

struct AddressCellViewModel {

  var address: String
  var lat: Double = 0.0
  var lng: Double = 0.0


  init(item: GeocoderResult) {

    self.address = item.address
    let location = item.geometry.location
    self.lat = location.lat
    self.lng = location.lng
  }
}
