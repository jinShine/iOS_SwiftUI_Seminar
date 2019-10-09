//
//  AddressSection.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/09.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import RxDataSources

enum SearchSection {
  case address(title: String, items: [SearchSectionItem])
}

enum SearchSectionItem {
  case addressItem(cellViewModel: AddressCellViewModel)
}

extension SearchSection: SectionModelType {
  typealias Item = SearchSectionItem
  
  var items: [SearchSectionItem] {
    switch self {
    case .address(_, let items): return items.map { $0 }
    }
  }
  
  init(original: SearchSection, items: [SearchSectionItem]) {
    switch original {
    case .address(let title, let items): self = .address(title: title, items: items)
    }
  }
}
