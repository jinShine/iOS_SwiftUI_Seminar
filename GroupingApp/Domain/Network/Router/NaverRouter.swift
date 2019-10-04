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
  static let naverClientID = "3BP2CA4bWQrkMSOeXv1d"
  static let naverClientSecret = "RSiPtAxVAE"

  var baseURL: URL {
    #if DEBUG
    return URL(string: "https://openapi.naver.com")!
    #else
    return URL(string: "https://openapi.naver.com")!
    #endif

  }

  var path: String {
    switch self {
    case .addressSearch:
      return "/v1/search/local.json"
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
        "display" : 30
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
        "X-Naver-Client-Id" : Router.naverClientID,
        "X-Naver-Client-Secret" : Router.naverClientSecret
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



