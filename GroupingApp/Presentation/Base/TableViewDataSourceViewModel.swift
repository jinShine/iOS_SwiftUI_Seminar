//
//  TableViewDataSourceViewModel.swift
//  GroupingApp
//
//  Created by Seungjin on 08/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

protocol TableViewDataSourceViewModel {

  func numberOfRowsInSection(section: Int) -> Int

  func numberOfSections() -> Int

  func listObject(at indexPath: IndexPath) -> Any?

  func objectFromUserInfo(userInfo: [AnyHashable: Any]) -> (type: AnyHashable, object: Any)
}

extension TableViewDataSourceViewModel {

  func objectFromUserInfo(userInfo: [AnyHashable: Any]) -> (type: AnyHashable, object: Any) {
    guard let key = userInfo.keys.first,
      let object = userInfo[key] else {
        return ("", "")
    }

    return (key, object)
  }
}
