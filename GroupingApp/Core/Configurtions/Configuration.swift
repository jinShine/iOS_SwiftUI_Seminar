//
//  Configuration.swift
//  GroupingApp
//
//  Created by Seungjin on 11/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import UIKit

struct Configuration {

  private enum Keys: String {
    case configuration = "google-api-key"
  }

  var scheme: String? {
      return Bundle.main.infoDictionary?[ApplicationConfiguration] as? String
  }

  var accessGoogleAPIKey: String? {
    guard let apiKey = getConfigurations()?[Keys.configuration.rawValue] as? String else {
      return nil
    }

    return apiKey
  }

  func getConfigurations() -> [String : Any]? {
    let fileName = "Configuration"
    let fileExtension = "plist"
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension),
      let configurations = NSDictionary(contentsOfFile: filePath) as? [String : Any] else {
        return [:]
    }

    return configurations
  }
}
