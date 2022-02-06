//
//  ContentItem.swift
//  Ex_SwiftUI
//
//  Created by buzz on 2022/02/07.
//

import Foundation

struct ContentItem: Identifiable {
  let id = UUID()
  let mainTitle: String
  let subTitle: String
  let imageName: String

  static var dummyData: [ContentItem] {
    (0...30).map { index in
      ContentItem(
        mainTitle: "MainTitle Index\(index)",
        subTitle: "Sub Title Index\(index)",
        imageName: "image_dog_\(index % 3 + 1)"
      )
    }
  }
}
