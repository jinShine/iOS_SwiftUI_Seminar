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

final class UserInfoRepository: UserInfoRepositoryType {
  
  func create(profileImage: Data?, name: String, number: String, crew: String, address: String?, email: String?, birth: String?, memo: String?) -> Observable<Void> {
    return Observable.empty()
  }
  
  func userInfoList() -> Observable<[UserInfoModel]> {
    return Observable.just([])
  }
  
}
