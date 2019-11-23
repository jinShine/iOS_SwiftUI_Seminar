//
//  GoogleUseCase.swift
//  GroupingApp
//
//  Created by Seungjin on 10/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol GoogleUseCase {
  func executeReverseGeocoding(addresss: String) -> Single<Geocoder>
}

final class GoogleUseCaseImpl: GoogleUseCase {

  private let googleRepository: GoogleRepository

  init(googleRepository: GoogleRepository) {
    self.googleRepository = googleRepository
  }

  func executeReverseGeocoding(addresss: String) -> Single<Geocoder> {
    googleRepository.requestGeocoding(addresss: addresss)
  }
}
