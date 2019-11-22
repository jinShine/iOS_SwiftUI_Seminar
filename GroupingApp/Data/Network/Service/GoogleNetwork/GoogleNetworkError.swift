//
//  GoogleNetworkError.swift
//  GroupingApp
//
//  Created by Seungjin on 22/11/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

public enum GoogleNetworkStatus: String {
  /// 성공
  case ok = "OK"
  /// reverse geocoding은 성공했지만 아무 결과값이 없음
  case noResult = "ZERO_RESULTS"
   /// 쿼리 할당량 초과
  case overQueryLimit = "OVER_QUERY_LIMIT"
  /// 서버에서 요청이 거부되었음
  case requestDenied = "REQUEST_DENIED"
  /// 서버 에러
  case serverError = "UNKNOWN_ERROR"

  static func message(status: GoogleNetworkStatus?) -> String {
    switch status {
    case .ok: return "성공"
    case .noResult: return "결과값 없음"
    case .overQueryLimit: return "쿼리 할당량 초과"
    case .requestDenied: return "서버에서 요청이 거부"
    case .serverError: return "서버 에러"
    default: return "서버에러"
    }
  }
}
