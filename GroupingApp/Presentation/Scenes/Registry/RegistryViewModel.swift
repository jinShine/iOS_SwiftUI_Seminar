//
//  RegistryViewModel.swift
//  GroupingApp
//
//  Created by Seungjin on 02/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class RegistryViewModel: ViewModelType {

  struct Input {
    let didTapDismiss: Driver<Void>
    let keyboardWillShowTrigger: Observable<Notification>
    let keyboardWillHideTrigger: Observable<Notification>
    let didTapAddPhoto: Driver<Void>
    let userModelValidation: Observable<UserModel>
    let didTapSave: Observable<UserModel>
    let showReceivedAddress: Observable<Void>
  }

  struct Output {
    let dismiss: Driver<Void>
    let keyboardHeight: Driver<CGFloat>
    let keyboardDidHide: Driver<Void>
    let pickerController: Driver<UIImagePickerController>
    let saveButtonEnable: Driver<Bool>
    let userInfoSave: Driver<Void>
    let didSetReceivedAddress: Driver<String>
  }

  //MARK: - Properties
  var navigator: RegistryNavigator?
  let userUseCase: UserUseCase
  var receivedAddress: String?


  //MARK: - Initialize
  init(userUseCase: UserUseCase) {
    self.userUseCase = userUseCase
  }

  func transform(input: Input) -> Output {

    let dismiss = input.didTapDismiss.map {
      if let navigator = self.navigator {
        navigator.navigate(to: .main)
      }
    }

    let keyboardHeight = input.keyboardWillShowTrigger
      .map { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
      .map { $0?.height ?? 0.0 }
      .asDriver(onErrorJustReturn: 0.0)

    let keyboardDidHide = input.keyboardWillHideTrigger
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())

    let pickerViewController = input.didTapAddPhoto
      .do(onNext: { _ in App.loading.show() })
      .map { UIImagePickerController() }
      .asDriver()

    let saveButtonEnable = input.userModelValidation
      .map { userModel -> Bool in
        guard userModel.name != "" && userModel.number != "" && userModel.crew != "" else {
          return false
        }
        return true
      }.asDriver(onErrorJustReturn: false)
    
    let userInfoSave = input.didTapSave
      .flatMap { userModel in
        return self.userUseCase.create(profileImage: userModel.profileImage, name: userModel.name, number: userModel.number, crew: userModel.crew, address: userModel.address, email: userModel.email, birth: userModel.birth, memo: userModel.memo)
      }.asDriver(onErrorJustReturn: ())

    let didSetReceivedAddress = input.showReceivedAddress
      .map { self.receivedAddress ?? "" }
      .asDriver(onErrorJustReturn: "")

    return Output(
      dismiss: dismiss,
      keyboardHeight: keyboardHeight,
      keyboardDidHide: keyboardDidHide,
      pickerController: pickerViewController,
      saveButtonEnable: saveButtonEnable,
      userInfoSave: userInfoSave,
      didSetReceivedAddress: didSetReceivedAddress
    )
  }

}
