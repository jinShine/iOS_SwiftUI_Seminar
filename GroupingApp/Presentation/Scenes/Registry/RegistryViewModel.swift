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
    let dismissAction: Driver<Void>
    let keyboardWillShowAction: Observable<Notification>
    let keyboardWillHideAction: Observable<Notification>
    let addPhotoAction: Driver<Void>
    let checkSaveValidationAction: Observable<(String, String, String)>
    let saveButtonAction: Observable<(String, String, String, String, String, String, String)>
    let showReceivedAddressAction: Observable<Void>
  }

  struct Output {
    let dismissState: Driver<Void>
    let keyboardHeightState: Observable<CGFloat>
    let pickerControllerState: Driver<UIImagePickerController>
    let saveButtonEnableState: Driver<Bool>
    let userInfoSaveState: Driver<Void>
    let didSetReceivedAddressState: Driver<String>
  }

  //MARK: - Properties
  var navigator: RegistryNavigator
  let userInfoUseCase: UserInfoUseCase
  var receivedAddress: String?
  let profileImageSubject = BehaviorSubject<Data>(value: (UIImage(named: "Empty_Profile")?.pngData())!)
  let receivedAddressSubject = PublishSubject<String>()


  //MARK: - Initialize
  init(navigator: RegistryNavigator,
       userInfoUseCase: UserInfoUseCase) {
    self.navigator = navigator
    self.userInfoUseCase = userInfoUseCase
  }

  func transform(input: Input) -> Output {

    let dismissState = input.dismissAction
      .map { self.navigator.navigate(to: .main) }

    let keyboardWillShow = input.keyboardWillShowAction
      .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }
    
    let keyboardWillHide = input.keyboardWillHideAction
      .map { noti -> CGFloat in return 0 }
    
    let keyboardHeightState = Observable.merge(keyboardWillShow, keyboardWillHide)

    let pickerControllerState = input.addPhotoAction
      .do(onNext: { _ in App.loading.show() })
      .map { UIImagePickerController() }
      .asDriver()

    let saveButtonEnableState = input.checkSaveValidationAction
      .map { name, number, crew in
        guard name.isNotEmpty && number.isNotEmpty && crew.isNotEmpty else {
          return false
        }
        return true
      }.asDriver(onErrorJustReturn: false)

    let userInfoSaveState = input.saveButtonAction
      .flatMap { name, number, crew, address, email, birth, memo in
        return self.userInfoUseCase.executeCreate(profileImage: try! self.profileImageSubject.value(), name: name, number: number, crew: crew, address: address, email: email, birth: birth, memo: memo)
      }
      .map { _ in self.navigator.navigate(to: .main) }
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())

    let didSetReceivedAddressState = input.showReceivedAddressAction
      .map { self.receivedAddressSubject.onNext(self.receivedAddress ?? "") }
      .map { self.receivedAddress ?? "" }
      .asDriver(onErrorJustReturn: "")

    return Output(
      dismissState: dismissState,
      keyboardHeightState: keyboardHeightState,
      pickerControllerState: pickerControllerState,
      saveButtonEnableState: saveButtonEnableState,
      userInfoSaveState: userInfoSaveState,
      didSetReceivedAddressState: didSetReceivedAddressState
    )
  }

}
