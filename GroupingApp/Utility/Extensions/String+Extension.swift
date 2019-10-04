//
//  String+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

//MARK: - 스트링 로컬라이제이션 적용
extension String {
  var localize: String {
    return NSLocalizedString(self, comment: self)
  }
}
