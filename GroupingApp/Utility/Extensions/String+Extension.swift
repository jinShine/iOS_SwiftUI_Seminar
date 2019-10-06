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
  public var localize: String {
    return NSLocalizedString(self, comment: self)
  }
}

//MARK:- HTML Tag 제거
extension String {
  public var removeHTMLTags: String {

//    guard let data = self.data(using: .utf8) else { return nil }
//    let options: [NSAttributedString.DocumentReadingOptionKey : Any] = [
//      .documentType: NSAttributedString.DocumentType.html,
//      .characterEncoding: String.Encoding.utf8.rawValue
//    ]
//    guard let attributedString = try? NSAttributedString(data: data, options: options, documentAttributes: .none) else { return nil }
//    
//    return attributedString
    return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
  }
}
