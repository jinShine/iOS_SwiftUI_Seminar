//
//  UserUseCase.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/04.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift

protocol UserInfoUseCase {
  func executeCreate(profileImage: Data,
                     name: String,
                     number: String,
                     crew: String,
                     address: String?,
                     email: String?,
                     birth: String?,
                     memo: String?) -> Observable<UserInfoModel>
  
  func executeList() -> Observable<[UserInfoSectionModel]>
}

final class UserInfoUseCaseImpl: UserInfoUseCase {
  
  private let userInfoRepository: UserInfoRepository
  
  init(userInfoRepository: UserInfoRepository) {
    self.userInfoRepository = userInfoRepository
  }
  
  func executeCreate(profileImage: Data, name: String, number: String, crew: String, address: String?, email: String?, birth: String?, memo: String?) -> Observable<UserInfoModel> {
    return userInfoRepository.create(profileImage: profileImage, name: name, number: number, crew: crew, address: address, email: email, birth: birth, memo: memo)
  }
  
  func executeList() -> Observable<[UserInfoSectionModel]> {
    return userInfoRepository.userInfoList()
  }
  
}

