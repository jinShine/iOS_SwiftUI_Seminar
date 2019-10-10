//
//  GoogleUseCase.swift
//  GroupingApp
//
//  Created by Seungjin on 10/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol GoogleUseCase {
  func requestGeocoding(addrsss: String) -> Single<Geocoder>
}
