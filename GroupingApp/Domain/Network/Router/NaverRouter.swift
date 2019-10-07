//
//  NaverRouter.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Moya

enum Router {
  case addressSearch(address: String)
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
    case .addressSearch:
      return "/map-place/v1/search"
    }
  }

  var method: Method {
    switch self {
    case .addressSearch:
      return .get
    }
  }

  var parameters: [String: Any]? {
    switch self {
    case .addressSearch(let address):
      return [
        "query" : address,
        "coordinate" : "127.1054328,37.3595963"
      ]
    }
  }

  var task: Task {
    switch self {
    case .addressSearch:
      return .requestParameters(parameters: parameters!, encoding: URLEncoding.default)
    }
  }

  var headers: [String : String]? {
    switch self {
    case .addressSearch:
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



