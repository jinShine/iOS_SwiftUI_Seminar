//
//  SessionModel.swift
//  GroupingApp
//
//  Created by Seungjin on 11/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct SessionKey {
  static let googleToken: String = "com.jinnify.groupingapp.googletoken"
}

class SessionModel {

  var googleToken: String? {
    guard let googleToken = App.userDefaultsManager.objectForKey(key: SessionKey.googleToken, type: .keychain) as? String else {
      return nil
    }

    return googleToken
  }

}
