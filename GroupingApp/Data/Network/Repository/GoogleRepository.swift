//
//  GoogleRepository.swift
//  GroupingApp
//
//  Created by Seungjin on 21/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

final class GoogleRepository {

  private let googleNetworkService: GoogleNetworkService

  init(googleNetworkService: GoogleNetworkService = GoogleNetworkService()) {
    self.googleNetworkService = googleNetworkService
  }

}

extension GoogleRepository: GoogleRepositoryType {

  func requestGeocoding(addresss: String) -> Single<Geocoder> {
    return googleNetworkService.buildRequest(to: .geocode(address: addresss))
      .map { response in
        let result = try JSONDecoder().decode(Geocoder.self, from: response.jsonData ?? Data())
        let status = GoogleNetworkStatus(rawValue: result.status)

        guard status == .ok || status == .noResult else {
          log.error(GoogleNetworkStatus.message(status: status))
          return result
        }

        log.debug(result)

        return result
    }
  }

}
