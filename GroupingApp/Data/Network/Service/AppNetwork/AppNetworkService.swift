//
//  AppNetworkService.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import Moya
import Alamofire

struct AppNetworkService {

  static private let sharedManager: Alamofire.SessionManager = {
    let configuration = URLSessionConfiguration.default
    configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
    configuration.timeoutIntervalForRequest = 20
    configuration.timeoutIntervalForResource = 20
    configuration.requestCachePolicy = NSURLRequest.CachePolicy.useProtocolCachePolicy
    return Alamofire.SessionManager(configuration: configuration)
  }()

  private let provider: MoyaProvider<AppRouter> = {
    let provider = MoyaProvider<AppRouter>(endpointClosure: MoyaProvider.defaultEndpointMapping,
                                        requestClosure: MoyaProvider<AppRouter>.defaultRequestMapping,
                                        stubClosure: MoyaProvider.neverStub,
                                        callbackQueue: nil,
                                        manager: sharedManager,
                                        plugins: [],
                                        trackInflights: false)
    return provider
  }()


  func buildRequest(to router: AppRouter) -> Single<NetworkDataResponse> {
    return self.provider.rx.request(router)
        .flatMap { response -> Single<NetworkDataResponse> in
          return Single.create(subscribe: { single -> Disposable in
            let requestStatusCode = NetworkStatusCode(rawValue: response.response?.statusCode ?? 0)
            
            guard requestStatusCode != .unauthorized && requestStatusCode != .forbidden else {
              single(.error(RequestError.invalidRequest))
              return Disposables.create()
            }

            single(.success(NetworkDataResponse(jsonData: response.data)))

            return Disposables.create()
          })
        }
  }

}


