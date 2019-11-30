//
//  HomeViewModel.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

typealias UserInfoSectionModel = AnimatableSectionModel<Int, UserInfoModel>

final class UserInfoListViewModel: ViewModelType {
  
  let datasource: RxTableViewSectionedAnimatedDataSource<UserInfoSectionModel> = {
    let ds = RxTableViewSectionedAnimatedDataSource<UserInfoSectionModel> (configureCell: { datasource, tableView, indexPath, item -> UITableViewCell in
      
      let cell = tableView.dequeueReusableCell(withIdentifier: UserInfoListCell.reuseIdentifier, for: indexPath) as! UserInfoListCell
      
      cell.profileImageView.image = UIImage(data: item.profileImage)
      cell.nameLabel.text = item.name
      cell.addressLabel.text = item.address
      cell.numberLabel.text = item.number
      cell.crewLabel.setTitle(item.crew, for: .normal)
      
      return cell
    })
    return ds
  }()

  struct Input {
    let userInfoListAction: Observable<Void>
  }

  struct Output {
    let userInfoListState: Observable<[UserInfoSectionModel]>
  }

  //MARK: - Properties
  var navigator: UserInfoListNavigator
  let userInfoUseCase: UserInfoUseCase

  //MARK: - Initialize
  init(navigator: UserInfoListNavigator,
       userInfoUseCase: UserInfoUseCase) {
    self.navigator = navigator
    self.userInfoUseCase = userInfoUseCase
  }

  func transform(input: Input) -> Output {
    
    let userInfoListState = input.userInfoListAction.flatMap { _ -> Observable<[UserInfoSectionModel]> in
      return self.userInfoUseCase.executeList()
    }

    return Output(userInfoListState: userInfoListState)
  }

}
