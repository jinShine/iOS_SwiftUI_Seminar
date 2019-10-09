//
//  Logger.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/09.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import CocoaLumberjack

/// A shared instance of `Logger`.
let log = Logger()

final class Logger {
  
  init() {
    setenv("XcodeColors", "YES", 0)

    
    // TTY = Xcode console
    
//    DDTTYLogger.sharedInstance.do {
//      $0.logFormatter = LogFormatter()
//      $0.colorsEnabled = false /*true*/ // Note: doesn't work in Xcode 8
//      $0.setForegroundColor(DDMakeColor(30, 121, 214), backgroundColor: nil, for: .info)
//      $0.setForegroundColor(DDMakeColor(50, 143, 72), backgroundColor: nil, for: .debug)
//      DDLog.add($0)
//    }
//
//    // File logger
//    DDFileLogger().do {
//      $0.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
//      $0.logFileManager.maximumNumberOfLogFiles = 7
//      DDLog.add($0)
//    }
  }
}

