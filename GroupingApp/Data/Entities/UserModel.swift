//
//  UserModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/04.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation

struct UserModel {
  var name: String
  var number: String
  var crew: String
  var address: String?
  var email: String?
  var birth: String?
  
  init(name: String,
       number: String,
       crew: String,
       address: String?,
       email: String?,
       birth: String?) {
    
    self.name = name
    self.number = number
    self.crew =  crew
    self.address = address
    self.email = email
    self.birth = birth
  }
}
