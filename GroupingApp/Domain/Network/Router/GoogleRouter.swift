//
//  GoogleRouter.swift
//  GroupingApp
//
//  Created by Seungjin on 10/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import Alamofire
import Moya


enum GoogleRouter {
  case geocode(address: String)
}

enum GoogleRouterError: Error {
  case message
}

extension GoogleRouter: TargetType {

  //Google Key
  static let apiKey = App.configuration.accessGoogleAPIKey

  var baseURL: URL {
    #if DEBUG
    return URL(string: "https://maps.googleapis.com")!
    #else
    return URL(string: "https://maps.googleapis.com")!
    #endif

  }

  var path: String {
    switch self {
    case .geocode:
      return "/maps/api/geocode/json"
    }
  }

  var method: Alamofire.HTTPMethod {
    switch self {
    case .geocode:
      return .get
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .geocode(let address):
      return [
        "address" : address,
        "language" : "ko",
        "key" : GoogleRouter.apiKey
      ]
    }
  }

  var task: Task {
    switch self {
    case .geocode:
      return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
    }
  }

  var headers: [String : String]? {
    switch self {
    case .geocode:
      return [:]
    }
  }

  var sampleData: Data {
    return "data".data(using: String.Encoding.utf8)!
  }
}

//MARK: - Error
extension GoogleRouterError: CustomStringConvertible {
  var description: String {
    switch self {
    case .message:
      return "NetworkErrorMessageBody".localize
    }
  }
}





