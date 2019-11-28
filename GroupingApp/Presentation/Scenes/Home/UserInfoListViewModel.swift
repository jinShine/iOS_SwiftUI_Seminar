//
//  HomeViewModel.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class UserInfoListViewModel: BindViewModelType {

  //MARK: - Constant

  struct Constant {

  }


  //MARK: - Unidirection

  enum Command {

  }

  enum Action {

  }

  enum State {

  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




  //MARK: - Properties



  //MARK: - Initialize
  init() {

    self.bind()
  }


  //MARK: - Unidirection Action

  func toAction(from command: Command) -> Observable<Action> {
    return Observable<Action>.empty()
  }

  func toState(from action: Action) -> Observable<State> {
    return Observable<State>.empty()
  }

}

//MARK: - Method Handler
extension UserInfoListViewModel {


}

