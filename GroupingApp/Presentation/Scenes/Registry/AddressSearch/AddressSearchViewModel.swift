//
//  AddressSearchViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AddressSearchViewModel: BindViewModelType {

  //MARK: - Constant

  struct Constant {

  }


  //MARK: - Unidirection

  enum Command {
    case pop
  }

  enum Action {
    case popAction
  }

  enum State {
    case popState
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
    switch command {
    case .pop:
      return Observable<Action>.just(.popAction)
      
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .popAction:
      return Observable<State>.just(.popState)
      
    }
  }

}

//MARK: - Method Handler
extension AddressSearchViewModel {


}
