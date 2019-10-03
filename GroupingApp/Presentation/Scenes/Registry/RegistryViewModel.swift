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
  }

  enum Action {
    case dismissAction
    case keyboardWillShowAction(Notification)
    case keyboardWillHideAction
    case didTapAddPhtoAction
  }

  enum State {
    case dismissState
    case keyboardWillShowState(CGFloat)
    case keyboardWillHideState
    case didTapAddPhtoState
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
    case .dismiss:
      return Observable<Action>.just(.dismissAction)
    case .keyboardWillShow(let noti):
      return Observable<Action>.just(.keyboardWillShowAction(noti))
    case .keyboardWillHide:
      return Observable<Action>.just(.keyboardWillHideAction)
    case .didTapAddPhto:
      return Observable<Action>.just(.didTapAddPhtoAction)
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
    }
  }

}

//MARK: - Method Handler
extension RegistryViewModel {

  private func setupUI() {

  }

  private func setupConstraint() {

  }

}

