//
//  Logger.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/09.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import CocoaLumberjack

/// A shared instance of `Logger`.
let log = Logger()

final class Logger {
  
  init() {
    setenv("XcodeColors", "YES", 0)
    
    //Uses os_log
    let ddos = DDOSLogger.sharedInstance
    ddos?.logFormatter = LogFormatter()
    DDLog.add(DDOSLogger.sharedInstance)
    
    //File Logger
    let fileLogger = DDFileLogger()
    fileLogger.rollingFrequency = TimeInterval(60 * 60 * 24)  // 24 hours
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7
    DDLog.add(fileLogger)
  }
  
  // MARK: Logging

  func error(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogError(message, file: file, function: function, line: line)
  }

  func warning(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogWarn(message, file: file, function: function, line: line)
  }

  func info(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogInfo(message, file: file, function: function, line: line)
  }

  func debug(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogDebug(message, file: file, function: function, line: line)
  }

  func verbose(
    _ items: Any...,
    file: StaticString = #file,
    function: StaticString = #function,
    line: UInt = #line
  ) {
    let message = self.message(from: items)
    DDLogVerbose(message, file: file, function: function, line: line)
  }


  // MARK: Utils

  private func message(from items: [Any]) -> String {
    return items
      .map { String(describing: $0) }
      .joined(separator: " ")
  }
}

private class LogFormatter: NSObject, DDLogFormatter {

  static let dateFormatter: DateFormatter = {
    let dateformat = DateFormatter()
    dateformat.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
    return dateformat
  }()

  public func format(message logMessage: DDLogMessage) -> String? {
    let timestamp = LogFormatter.dateFormatter.string(from: logMessage.timestamp)
    let level = logMessage.flag.level
    let filename = logMessage.fileName
    let function = logMessage.function ?? ""
    let line = logMessage.line
    let message = logMessage.message.components(separatedBy: "\n").joined(separator: "\n    ")
    return "\(timestamp) \(level) \(filename).\(function):\(line) - \(message)"
  }

  private func formattedDate(from date: Date) -> String {
    return LogFormatter.dateFormatter.string(from: date)
  }
}

extension DDLogFlag {
  public var level: String {
    switch self {
    case DDLogFlag.error: return "❤️ ERROR"
    case DDLogFlag.warning: return "💛 WARNING"
    case DDLogFlag.info: return "💙 INFO"
    case DDLogFlag.debug: return "💚 DEBUG"
    case DDLogFlag.verbose: return "💜 VERBOSE"
    default: return "☠️ UNKNOWN"
    }
  }
}
