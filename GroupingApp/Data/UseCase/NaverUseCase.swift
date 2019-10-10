//
//  NaverUseCase.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol NaverUseCase {
  func requestAddress(address: String) -> Single<Geocoder>
}
