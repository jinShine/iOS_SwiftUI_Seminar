//
//  GoogleRepositoryType.swift
//  GroupingApp
//
//  Created by Seungjin on 21/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol GoogleRepositoryType {
  func requestGeocoding(addresss: String) -> Single<Geocoder>
}
