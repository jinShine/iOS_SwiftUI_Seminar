//
//  String+Extension.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

extension String {

  //스트링 로컬라이제이션 적용
  public var localize: String {
    return NSLocalizedString(self, comment: self)
  }

  //HTML Tag 제거
  public var removeHTMLTags: String {
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }

}

