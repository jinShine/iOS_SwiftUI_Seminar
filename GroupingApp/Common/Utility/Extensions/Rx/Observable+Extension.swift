//
//  Observable+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 23/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

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
