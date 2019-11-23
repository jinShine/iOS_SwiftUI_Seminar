//
//  UserInteractor.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/04.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreData

final class UserInteractor {

//  let coreData = App.coreData
//
//  func showAll() {
//    self.coreData.context.performAndWait {
//      let request: NSFetchRequest<UserInfomation> = UserInfomation.fetchRequest()
//      let list = try? self.coreData.context.fetch(request)
//      list?.forEach { log.debug($0) }
//    }
//  }
//
//  func show() {
//    self.coreData.context.performAndWait {
//      let request: NSFetchRequest<UserInfomation> = UserInfomation.fetchRequest()
//      do {
//        if let last = try self.coreData.context.fetch(request).last {
//          #if DEBUG
//          log.debug(last)
//          #endif
//        }
//      } catch {
//        log.error("CoreData Show Error")
//      }
//    }
//  }
//
//  func create(profileImage: Data?, name: String, number: String, crew: String, address: String?, email: String?, birth: String?, memo: String?) -> Single<Void> {
//
//    return Single.create { (single) -> Disposable in
//
//      self.coreData.context.perform {
//        let newUserInfo = UserInfomation(context: self.coreData.context)
//        newUserInfo.profile = profileImage
//        newUserInfo.name = name
//        newUserInfo.number = number
//        newUserInfo.crew = crew
//        newUserInfo.address = address
//        newUserInfo.email = email
//        newUserInfo.birth = birth
//        newUserInfo.memo = memo
//
//        self.coreData.saveContext()
//        self.show()
//
//        single(.success(()))
//      }
//
//      return Disposables.create()
//    }
//  }


}
