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
