//
//  Binder+Extension.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/21.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
  var contentInset: Binder<UIEdgeInsets> {
    return Binder(self.base) { (scrollView, inset) in
      scrollView.contentInset = inset
    }
  }
}
