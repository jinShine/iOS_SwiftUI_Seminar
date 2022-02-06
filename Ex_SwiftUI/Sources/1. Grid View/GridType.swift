//
//  GridType.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import Foundation
import SwiftUI

enum GridType: CaseIterable {
  case single
  case double
  case triple
  case adaptive

  var columns: [GridItem] {
    switch self {
    case .single:
      return [GridItem(.flexible())]
    case .double:
      return [
        GridItem(.flexible()),
        GridItem(.flexible())
      ]
    case .triple:
      return [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
      ]
    case .adaptive:
      return [GridItem(.adaptive(minimum: 80))]
    }
  }
}
