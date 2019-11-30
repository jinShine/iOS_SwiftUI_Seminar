//
//  AppDelegate.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    setup()
    
//    CoreDataManager(modelName: "GroupingApp").delete()
    return true
  }
  
}

extension AppDelegate {

  private func setup() {
    
    //Google
    GMSServices.provideAPIKey(App.configuration.accessGoogleAPIKey)

  }
}
