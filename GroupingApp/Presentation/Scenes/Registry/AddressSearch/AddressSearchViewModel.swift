//
//  AddressSearchViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa
import GoogleMaps

final class AddressSearchViewModel: ViewModelType {

  struct Input {
    let popButtonAction: Driver<Void>
    let locationStartAction: Driver<Void>
    let locationFetchAction: Driver<Void>
    let addressSearchAction: Driver<String>
    let keyboardWillShowAction: Observable<Notification>
    let keyboardWillHideAction: Observable<Notification>
    let saveButtonAction: Observable<String>
  }
  
  struct Output {
    let popState: Driver<Void>
    let locationStartState: Driver<Void>
    let locationUpdateState: Driver<LocationResponse>
    let addressSearchState: Driver<Geocoder>
    let keyboardHeightState: Driver<CGFloat>
    let popAfterSaveState: Driver<Void>
  }
  
  //MARK: - Properties
  let navigator: AddressSearchNavigator
  let googleUseCase: GoogleUseCase
  let locationUseCase: LocationUseCase


  //MARK: - Initialize
  init(navigator: AddressSearchNavigator,
       googleUseCase: GoogleUseCase,
       locationUseCase: LocationUseCase) {
    self.navigator = navigator
    self.googleUseCase = googleUseCase
    self.locationUseCase = locationUseCase
  }

  func transform(input: Input) -> Output {

    let popState = input.popButtonAction
      .map { self.navigator.navigate(to: .registry(address: nil)) }

    let locationStartState = input.locationStartAction
      .flatMapLatest { self.locationUseCase.start().asDriver(onErrorJustReturn: ()) }

    let locationUpdateState = input.locationFetchAction.flatMapLatest {
      self.locationUseCase.fetch()
        .take(1)
        .asDriver(onErrorJustReturn: (nil, nil))
    }

    let addressSearchState = input.addressSearchAction
      .flatMapLatest {
        return self.googleUseCase.executeReverseGeocoding(addresss: $0)
          .map { $0 }
          .asDriver(onErrorJustReturn: Geocoder())
      }
    
    let keyboardWillShow = input.keyboardWillShowAction
      .map { ($0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height ?? 0}
      .asDriver(onErrorJustReturn: 0.0)

    let keyboardWillHide = input.keyboardWillHideAction
      .map { noti -> CGFloat in return 0.0 }
      .asDriver(onErrorJustReturn: 0.0)

    let keyboardHeightState = Driver.merge(keyboardWillShow, keyboardWillHide)

    let popAfterSaveState = input.saveButtonAction
      .map { self.navigator.navigate(to: .registry(address: $0))}
      .asDriver(onErrorJustReturn: ())
    

    return Output(
      popState: popState,
      locationStartState: locationStartState,
      locationUpdateState: locationUpdateState,
      addressSearchState: addressSearchState,
      keyboardHeightState: keyboardHeightState,
      popAfterSaveState: popAfterSaveState
    )
  }
}

//MARK: - Methods
extension AddressSearchViewModel {

  var defaultCoordinate: CLLocationCoordinate2D {
    // 시청역 기본값
    return CLLocationCoordinate2DMake(37.566676, 126.978804)
  }

  func reverseGeocodeCoordinate(geocoder: GMSGeocoder,
                                location: CLLocation?,
                                completion: @escaping (String) -> Void) {
    if let location = location {
      geocoder.reverseGeocodeCoordinate(location.coordinate) { (response, error) in
        if let address = response,
          let result = address.firstResult(),
          let line = result.lines?.first {
          completion(line.removalRepublicKorea())
        }
      }
    } else {
      completion("현재 위치를 찾을 수 없습니다.")
    }
  }
}

extension String {
  public func removalRepublicKorea() -> String {
    if self.contains("대한민국 ") {
      return self.components(separatedBy: "대한민국 ").last ?? ""
    } else {
      return self
    }
  }
}

