//
//  UserInteractor.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/04.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class UserInteractor: UserUseCase {

  let coreData = App.coreData
  
  func create(profileImage: Data?, name: String, number: String, crew: String, address: String?, email: String?, birth: String?, memo: String?) -> Single<Void> {

    return Single.create { (single) -> Disposable in

      self.coreData.context.perform {
        let newUserInfo = UserInfomation(context: self.coreData.context)
        newUserInfo.profile = profileImage
        newUserInfo.name = name
        newUserInfo.number = number
        newUserInfo.crew = crew
        newUserInfo.address = address
        newUserInfo.email = email
        newUserInfo.birth = birth
        newUserInfo.memo = memo

        self.coreData.saveContext()
        single(.success(()))
      }

      return Disposables.create()
    }

  }
  
  
}
