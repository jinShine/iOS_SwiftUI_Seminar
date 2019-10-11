//
//  UserDefaultsManager.swift
//  GroupingApp
//
//  Created by Seungjin on 11/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import KeychainAccess

struct UserDefaultsManger {

  ///singleton
  static let `default` = UserDefaultsManger()

  enum PersistanceType: Int {
      case userDefaults, keychain
  }

  private let keyChain = Keychain()

  func setObejct(object: Any?, key: String, type: PersistanceType) {
      if type == .keychain {
          setObjectInKeychain(object: object, key: key)
      }
      else {
          setObjectInUserDefaults(object: object, key: key)
      }
  }

  func objectForKey(key: String, type: PersistanceType) -> Any? {
      var value: Any?
      if type == .keychain {
          value = objectFromKeychain(key: key)
      }
      else {
          value = objectFromUserDefaults(key: key)
      }

      return value
  }

  func removeObject(key: String, type: PersistanceType) {
      if type == .keychain {
          removetObjectFromKeychain(key: key)
      }
      else {
          removetObjectFromUserDefaults(key: key)
      }
  }

  func reset(keepKeys: [String]? = nil) {
     resetUserDefaults(keepKeys)
     resetKeyChain(keepKeys)
  }

  // MARK:- User Defalts

  private func setObjectInUserDefaults(object: Any?, key: String) {
      UserDefaults.standard.set(object, forKey: key)
  }

  private func objectFromUserDefaults(key: String) -> Any? {
      return UserDefaults.standard.value(forKey: key)
  }

  private func removetObjectFromUserDefaults(key: String) {
      UserDefaults.standard.removeObject(forKey: key)
      UserDefaults.standard.synchronize()
  }

  private func resetUserDefaults(_ keepKeys: [String]? = nil) {
      let userDefaults = UserDefaults.standard

      guard let keys = keepKeys, keys.count > 0 else {
          guard let domain = Bundle.main.bundleIdentifier else {
              return
          }

          userDefaults.removePersistentDomain(forName: domain)
          userDefaults.synchronize()
          return
      }

      let userKeys = userDefaults.dictionaryRepresentation().keys
      let deletableKeys = userKeys.filter { !keys.contains($0) }

      for key in deletableKeys {
          removeObject(key: key, type: .userDefaults)
      }
  }

  // MARK:- Key chain

  private func setObjectInKeychain(object: Any?, key: String) {
      guard let obj = object as? String else {
          return
      }
      keyChain[key] = obj
  }

  private func objectFromKeychain(key: String) -> Any? {
      return keyChain[key]
  }

  private func removetObjectFromKeychain(key: String) {
      try? keyChain.remove(key)
  }

  private func resetKeyChain(_ keepKeys: [String]? = nil) {
      guard let keys = keepKeys, keys.count > 0 else {
          try? keyChain.removeAll()
          return
      }

      let userKeys = keyChain.allKeys()
      let deletableKeys = userKeys.filter { !keys.contains($0) }

      for key in deletableKeys {
          removeObject(key: key, type: .keychain)
      }
  }

}
