//
//  UserModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/04.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import CoreData
import RxCoreData

struct UserInfoModel: Equatable, Identifiable {

  var id: String
  var profileImage: Data?
  var name: String
  var number: String
  var crew: String
  var address: String?
  var email: String?
  var birth: String?
  var memo: String?
  
  init(profileImage: Data?,
       name: String,
       number: String,
       crew: String,
       address: String?,
       email: String?,
       birth: String?,
       memo: String?) {
    
    self.id = "\(Date().timeIntervalSinceReferenceDate)"
    self.profileImage = profileImage
    self.name = name
    self.number = number
    self.crew =  crew
    self.address = address
    self.email = email
    self.birth = birth
    self.memo = memo
  }
}

extension UserInfoModel: Persistable {
  
  var identity: String {
    return "\(Date().timeIntervalSinceReferenceDate)"
  }
  
  public static var entityName: String {
    return "UserInfomation"
  }

  static var primaryAttributeName: String {
    return "id"
  }

  init(entity: NSManagedObject) {
    id = "\(Date().timeIntervalSinceReferenceDate)"
    profileImage = entity.value(forKey: "profile") as? Data
    number = entity.value(forKey: "number") as! String
    name = entity.value(forKey: "name") as! String
    crew = entity.value(forKey: "crew") as! String
    address = entity.value(forKey: "address") as? String
    email = entity.value(forKey: "email") as? String
    birth = entity.value(forKey: "birth") as? String
    memo = entity.value(forKey: "memo") as? String
  }

  func update(_ entity: NSManagedObject) {
    entity.setValue("\(Date().timeIntervalSinceReferenceDate)", forKey: "id")
    entity.setValue(profileImage, forKey: "profile")
    entity.setValue(number, forKey: "number")
    entity.setValue(name, forKey: "name")
    entity.setValue(crew, forKey: "crew")
    entity.setValue(address, forKey: "address")
    entity.setValue(email, forKey: "email")
    entity.setValue(birth, forKey: "birth")
    entity.setValue(memo, forKey: "memo")
    
    do {
      try entity.managedObjectContext?.save()
    } catch {
      print(error)
    }
  }
  
}
