//
//  UserInfoRepositoryType.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/24.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol UserInfoRepositoryType {
  
  @discardableResult
  func create(profileImage: Data?,
              name: String,
              number: String,
              crew: String,
              address: String?,
              email: String?,
              birth: String?,
              memo: String?) -> Observable<UserInfoModel>
  
  @discardableResult
  func userInfoList() -> Observable<[UserInfoModel]>
  
}
