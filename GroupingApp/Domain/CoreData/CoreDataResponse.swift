//
//  CoreDataResponse.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

enum CoreDataResult {
  case success
  case failure
}

struct CoreDataResponse {
  let result: CoreDataResult
  let error: CoreDataResult?
}
