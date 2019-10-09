//
//  AppDelegate.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import CoreData
import NMapsMap

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
   
    //CoreData
    App.coreData.setup(modelName: "GroupingApp")
    
    //Naver Map Key
    NMFAuthManager.shared().clientId = "dykuz0db92"
    
    return true
  }
  
}
