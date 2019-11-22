//
//  ResponseTransformer.swift
//  GroupingApp
//
//  Created by Seungjin on 22/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import Alamofire

struct ResponseTransformer<T> {

  let dataResponse: DataResponse<T>

  func transform() -> NetworkDataResponse {
    var jsonData: Data?
    if let data = dataResponse.data {
      jsonData = data
    }

    var networkError: NetworkError?
    if let error = dataResponse.error {
      networkError = NetworkErrorBuilder.networkError(from: error)
    }

    let result: NetworkResult = networkError == nil ? .success : .failure

    let response = NetworkDataResponse(jsonData: jsonData,
                                       result: result,
                                       error: networkError)

    return response
  }
}
