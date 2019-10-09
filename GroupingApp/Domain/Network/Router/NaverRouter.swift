//
//  NaverRouter.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Moya

enum Router {
  case geocode(address: String)
}

enum RouterError: Error {
  case message
}


extension Router: TargetType {

  //네이버 Key
  static let naverAPIKeyID = "dykuz0db92"
  static let naverAPIKey = "WHZf2S82iMi8YJMSv2Mnjkzva43An0jbyRvuOFhj"

  var baseURL: URL {
    #if DEBUG
    return URL(string: "https://naveropenapi.apigw.ntruss.com")!
    #else
    return URL(string: "https://naveropenapi.apigw.ntruss.com")!
    #endif

  }

  var path: String {
    switch self {
    case .geocode:
      return "/map-geocode/v2/geocode"
    }
  }

  var method: Method {
    switch self {
    case .geocode:
      return .get
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .geocode(let address):
      return [
        "query" : address,
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
      return [
        "X-NCP-APIGW-API-KEY-ID" : Router.naverAPIKeyID,
        "X-NCP-APIGW-API-KEY" : Router.naverAPIKey
      ]
    }
  }

  var sampleData: Data {
    return "data".data(using: String.Encoding.utf8)!
  }
}

//MARK: - Error
extension RouterError: CustomStringConvertible {
  var description: String {
    switch self {
    case .message:
      return "NetworkErrorMessageBody".localize
    }
  }
}



