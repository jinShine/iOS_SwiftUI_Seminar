//
//  CoreDataManager.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//


import Foundation
import CoreData

class CoreDataManager {
  
  static let shared = CoreDataManager()
  private init() {}
  
  private var container: NSPersistentContainer?
  var context: NSManagedObjectContext {
    guard let context = container?.viewContext else {
      fatalError()
    }
    return context
  }
  
  func setup(modelName: String) {
    container = NSPersistentContainer(name: modelName)
    container?.loadPersistentStores(completionHandler: { (desc, error) in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
  
  func saveContext() {
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
}
