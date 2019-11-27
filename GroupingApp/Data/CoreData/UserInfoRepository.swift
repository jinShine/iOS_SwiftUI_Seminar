//
//  UserInfoRepository.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/24.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import RxCoreData
import CoreData

final class UserInfoRepository {

  private let coreDataManager: CoreDataManager

  init(coreDataManager: CoreDataManager) {
    self.coreDataManager = coreDataManager
  }

}

extension UserInfoRepository: UserInfoRepositoryType {
  
  @discardableResult
  func create(profileImage: Data?, name: String, number: String, crew: String, address: String?, email: String?, birth: String?, memo: String?) -> Observable<UserInfoModel> {
    
    let userInfoModel = UserInfoModel(profileImage: profileImage, name: name, number: number, crew: crew, address: address, email: email, birth: birth, memo: memo)
    
    do {
      _ = try coreDataManager.mainContext.rx.update(userInfoModel)
      return Observable.just(userInfoModel)
    } catch {
      return Observable.error(CoreDataError.saveError)
    }
  }
  
  @discardableResult
  func userInfoList() -> Observable<[UserInfoModel]> {
    
    return Observable.just([])
  }
  
}
