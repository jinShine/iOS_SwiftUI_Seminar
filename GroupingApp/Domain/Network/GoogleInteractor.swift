//
//  GoogleInteractor.swift
//  GroupingApp
//
//  Created by Seungjin on 10/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class GoogleInteractor: GoogleUseCase {

  func requestGeocoding(addrsss: String) -> Single<Geocoder> {
    return App.googleService.buildRequest(to: .geocode(address: addrsss))
      .map { response in
        do {
          let result = try JSONDecoder().decode(Geocoder.self, from: response.jsonData ?? Data())
          print("Result: ", result)

          return result
        }
    }
  }
}
