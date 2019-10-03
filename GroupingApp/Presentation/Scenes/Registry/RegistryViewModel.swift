//
//  RegistryViewModel.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class RegistryViewModel: BindViewModelType {

  //MARK: - Constant

  struct Constant {

  }


  //MARK: - Unidirection

  enum Command {
    case dismiss
    case keyboardWillShow(Notification)
    case keyboardWillHide
    case didTapAddPhto
    case didTapSave(name: String, number: String, crew: String,)
  }

  enum Action {
    case dismissAction
    case keyboardWillShowAction(Notification)
    case keyboardWillHideAction
    case didTapAddPhtoAction
    case didTapSaveAction(user: [String?])
  }

  enum State {
    case dismissState
    case keyboardWillShowState(CGFloat)
    case keyboardWillHideState
    case didTapAddPhtoState
    case didTapSaveState
  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




  //MARK: - Properties

  let userUseCase: UserUseCase

  //MARK: - Initialize
  init(userUseCase: UserUseCase) {
    self.userUseCase = userUseCase
    
    self.bind()
  }


  //MARK: - Unidirection Action

  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .dismiss:
      return Observable<Action>.just(.dismissAction)
    case .keyboardWillShow(let noti):
      return Observable<Action>.just(.keyboardWillShowAction(noti))
    case .keyboardWillHide:
      return Observable<Action>.just(.keyboardWillHideAction)
    case .didTapAddPhto:
      return Observable<Action>.just(.didTapAddPhtoAction)
    case .didTapSave(let userInfo):
      return Observable<Action>.just(.didTapSaveAction(user: userInfo))
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .dismissAction:
      return Observable<State>.just(.dismissState)
    case .keyboardWillShowAction(let noti):
      let keyboardFrame = noti.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
      let keyboardHeight = keyboardFrame?.height
      return Observable<State>.just(.keyboardWillShowState(keyboardHeight ?? 0))
    case .keyboardWillHideAction:
      return Observable<State>.just(.keyboardWillHideState)
    case .didTapAddPhtoAction:
      return Observable<State>.just(.didTapAddPhtoState)
    case .didTapSaveAction(let userInfo):
      
      userInfo.forEach {
        print($0)
        UserModel(name: <#T##String#>, number: <#T##String#>, crew: <#T##String#>, address: <#T##String?#>, email: <#T##String?#>, birth: <#T##String?#>)
      }
//      userUseCase.create(name: <#T##String#>, number: <#T##String#>, crew: <#T##String#>, address: <#T##String?#>, email: <#T##String?#>, birth: <#T##String?#>)
      return Observable<State>.just(.didTapSaveState)
    }
  }

}

//MARK: - Method Handler
extension RegistryViewModel {

}
