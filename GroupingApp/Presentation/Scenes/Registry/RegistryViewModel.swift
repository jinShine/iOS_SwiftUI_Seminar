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
    let saveButtonAction: Observable<(Data?, String, String, String, String, String, String, String)>
    let showReceivedAddressAction: Observable<Void>
  }

  struct Output {
    let dismiss: Driver<Void>
    let keyboardHeight: Observable<CGFloat>
    let pickerController: Driver<UIImagePickerController>
    let saveButtonEnable: Driver<Bool>
    let userInfoSave: Driver<Void>
    let didSetReceivedAddress: Driver<String>
  }

  //MARK: - Properties
  var navigator: RegistryNavigator?
  let userInfoUseCase: UserInfoUseCase
  var receivedAddress: String?
  let profileImageSubject = PublishSubject<Data?>()
  let receivedAddressSubject = PublishSubject<String>()


  //MARK: - Initialize
  init(userInfoUseCase: UserInfoUseCase) {
    self.userInfoUseCase = userInfoUseCase
  }

  func transform(input: Input) -> Output {

    let dismiss = input.dismissAction.map {
      if let navigator = self.navigator {
        navigator.navigate(to: .main)
      }
    }

    let keyboardWillShow = input.keyboardWillShowAction
      .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0 }
    
    let keyboardWillHide = input.keyboardWillHideAction
      .map { noti -> CGFloat in return 0 }
    
    let keyboardObservable = Observable.merge(keyboardWillShow, keyboardWillHide)

    let pickerViewController = input.addPhotoAction
      .do(onNext: { _ in App.loading.show() })
      .map { UIImagePickerController() }
      .asDriver()

    let saveButtonEnable = input.checkSaveValidationAction
      .map { name, number, crew in
        guard name.isNotEmpty && number.isNotEmpty && crew.isNotEmpty else {
          return false
        }
        return true
      }.asDriver(onErrorJustReturn: false)

    let userInfoSave = input.saveButtonAction
      .flatMap { profile, name, number, crew, address, email, birth, memo in
        return self.userInfoUseCase.executeCreate(profileImage: profile, name: name, number: number, crew: crew, address: address, email: email, birth: birth, memo: memo)
      }
      .map { self.navigator?.navigate(to: .main) }
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())
//      .flatMap { profile, name, number, crew, address, email, birth, memo in

//        return self.userUseCase.create(profileImage: userModel.profileImage, name: userModel.name, number: userModel.number, crew: userModel.crew, address: userModel.address, email: userModel.email, birth: userModel.birth, memo: userModel.memo)
//      }
//      .map { self.navigator?.navigate(to: .main) }
//      .mapToVoid()
//      .asDriver(onErrorJustReturn: ())
//      .map { profile, name, number, crew, address, email, birth, memo in
//        let userModel = UserModel(profileImage: profile, name: name, number: number, crew: crew, address: address, email: email, birth: birth, memo: memo)
//      }



//      .withLatestFrom((profileImageSubject, receivedAddressSubject))


//      .flatMap { userModel in
//        return self.userUseCase.create(profileImage: userModel.profileImage, name: userModel.name, number: userModel.number, crew: userModel.crew, address: userModel.address, email: userModel.email, birth: userModel.birth, memo: userModel.memo)
//      }
//      .map { self.navigator?.navigate(to: .main) }
//      .mapToVoid()
//      .asDriver(onErrorJustReturn: ())

    let didSetReceivedAddress = input.showReceivedAddressAction
      .map { self.receivedAddressSubject.onNext(self.receivedAddress ?? "") }
      .map { self.receivedAddress ?? "" }
      .asDriver(onErrorJustReturn: "")

    return Output(
      dismiss: dismiss,
      keyboardHeight: keyboardObservable,
      pickerController: pickerViewController,
      saveButtonEnable: saveButtonEnable,
      userInfoSave: userInfoSave,
      didSetReceivedAddress: didSetReceivedAddress
    )
  }

}
