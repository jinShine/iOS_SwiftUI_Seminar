//
//  Observable+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 23/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension SharedSequenceConvertibleType {
  func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
    return map { _ in }
  }
}

extension ObservableType {
  func mapToVoid() -> Observable<Void> {
    return map { _ in }
  }
}

extension ObservableType where E == CGFloat {
  func toContentInset(of scrollView: UIScrollView) -> Observable<UIEdgeInsets> {
    return map { height in
      var inset = scrollView.contentInset
      inset.bottom = height
      return inset
    }
  }
}
