//
//  NaverInteractor.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AddressInteractor: NaverUseCase {
  
  func requestAddress(address: String) -> Single<Geocode> {
    return App.service.buildRequest(to: .geocode(address: address))
      .map { response in
        do {
          let result = try JSONDecoder().decode(Geocode.self,
                                                from: response.jsonData ?? Data() )
          return result
        }
    }
  }
}
