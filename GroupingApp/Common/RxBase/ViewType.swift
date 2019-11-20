//
//  ViewType.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/21.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import RxSwift

protocol ViewType: class {
  associatedtype ViewModelType
  var viewModel: ViewModelType! { get set }
  func setupUI()
  func setupConstraints()
  func bindViewModel()
}

extension ViewType where Self: UIViewController {
  static func create(with viewModel: ViewModelType) -> Self {
    let `self` = Self()
    self.viewModel = viewModel
    self.loadViewIfNeeded()
    self.setupUI()
    self.setupConstraints()
    self.bindViewModel()
    return self
  }
}
