//
//  LocationUseCase.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/16.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol LocationUseCase {
  func fetch() -> Observable<LocationResponse>
  func start() -> Observable<Void>
}
