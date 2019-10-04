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
    case userValidation(user: UserModel)
    case didTapSave(user: UserModel)
  }

  enum Action {
    case dismissAction
    case keyboardWillShowAction(Notification)
    case keyboardWillHideAction
    case didTapAddPhtoAction
    case userValidationAction(user: UserModel)
    case didTapSaveAction(user: UserModel)
  }

  enum State {
    case dismissState
    case keyboardWillShowState(CGFloat)
    case keyboardWillHideState
    case didTapAddPhtoState
    case userValidationState(result: Bool)
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
    case .userValidation(let userInfo):
      return Observable<Action>.just(.userValidationAction(user: userInfo))
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
    case .userValidationAction(let userInfo):
      let result = saveValidation(userModel: userInfo)
      return Observable<State>.just(.userValidationState(result: result))
    case .didTapSaveAction(let userInfo):
      return userUseCase.create(name: userInfo.name, number: userInfo.number, crew: userInfo.crew, address: userInfo.address, email: userInfo.email, birth: userInfo.birth)
        .flatMap { _ in Single<State>.just(.didTapSaveState) }
        .asObservable()
    }
  }

}

//MARK: - Method Handler
extension RegistryViewModel {

  private func saveValidation(userModel: UserModel) -> Bool {
    guard userModel.name != "" && userModel.number != "" && userModel.crew != "" else {
      return false
    }

    return true
  }

}
