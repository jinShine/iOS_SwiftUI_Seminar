//
//  ViewModelType.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/21.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

protocol ViewModelType {
  associatedtype Input
  associatedtype Output
  
  func transform(input: Input) -> Output
}
