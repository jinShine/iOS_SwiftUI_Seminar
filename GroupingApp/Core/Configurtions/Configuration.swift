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

  /// Singleton
  static let shared = Configuration()
  
  private enum Keys: String {
    case googleAPIKey = "google-api-key"
  }

  var scheme: String? {
      return "Release"
  }

  var accessGoogleAPIKey: String {
    guard let apiKey = getConfigurations()?[Keys.googleAPIKey.rawValue] as? String else {
      return ""
    }

    return apiKey
  }

  func getConfigurations() -> [String : Any]? {
    let fileName = "Configuration"
    let fileExtension = "plist"
    guard let filePath = Bundle.main.path(forResource: fileName, ofType: fileExtension),
      let configurations = NSDictionary(contentsOfFile: filePath) as? [String : Any],
      let scheme = self.scheme,
      let bundleConfig = configurations[scheme] as? [String : Any] else {
        return nil
    }

    return bundleConfig
  }
  
  var version: String {
      let info = Bundle.main.infoDictionary
      let version = info?["CFBundleShortVersionString"] as? String ?? ""
    
      return "\(version)"
  }
  
  var buildVersion: String {
      let info = Bundle.main.infoDictionary
      let build = info?["CFBundleVersion"] as? String ?? ""
    
      return "\(build)"
  }
  
  var appIdentifier: String {
      return Bundle.main.infoDictionary?["CFBundleIdentifier"] as? String ?? ""
  }
  
  var systemVersion: String {
      return UIDevice.current.systemVersion
  }
  
}
