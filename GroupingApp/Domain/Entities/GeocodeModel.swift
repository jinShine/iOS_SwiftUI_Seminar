//
//  AddressModel.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct Geocoder: Decodable {

  var status: String
  var results: [GeocoderResult]

  init() {
    self.status = ""
    self.results = []
  }
}

struct GeocoderResult: Decodable {

  var address: String
  var geometry: Geometry?

  enum CodingKeys: String, CodingKey {
    case address = "formatted_address"
    case geometry
  }
}

// MARK: - Geometry
struct Geometry: Decodable {
    let location: Location

    enum CodingKeys: String, CodingKey {
        case location
    }
}

struct Location: Decodable {
    let lat, lng: Double
}
