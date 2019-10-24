//
//  AddressSearchViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class AddressSearchViewModel: ViewModelType {

  struct Input {
    let didTapPopButton: Driver<Void>
    let locationStart: Driver<Void>
    let locationFetch: Driver<Void>
    let didSearch: Driver<String>
    let keyboardWillShowTrigger: Observable<Notification>
    let keyboardWillHideTrigger: Observable<Notification>
    let selectedAddress: Observable<UIButton>
  }
  
  struct Output {
    let popViewController: Driver<Void>
    let locationStart: Driver<Void>
    let locationUpdate: Driver<LocationResponse>
    let searchedGeocoder: Driver<GeocoderResult>
    let keyboardHeight: Driver<CGFloat>
    let keyboardDidHide: Driver<Void>
  }
  
  //MARK: - Properties
  let navigator: AddressSearchNavigator
  let googleUseCase: GoogleUseCase
  let locationUseCase: LocationUseCase
  let geocoderSubject = PublishSubject<GeocoderResult>()


  //MARK: - Initialize
  init(navigator: AddressSearchNavigator,
       googleUseCase: GoogleUseCase,
       locationUseCase: LocationUseCase) {
    self.navigator = navigator
    self.googleUseCase = googleUseCase
    self.locationUseCase = locationUseCase
  }

  func transform(input: Input) -> Output {

    let popViewController = input.didTapPopButton
      .map { self.navigator.navigate(to: .registry(address: nil))
    }

    let starting = input.locationStart.flatMapLatest {
      self.locationUseCase.start().asDriver(onErrorJustReturn: ())
    }

    let fetching = input.locationFetch.flatMapLatest {
      self.locationUseCase.fetch().asDriver(onErrorJustReturn: (nil, nil))
    }

    let didSearch = input.didSearch.flatMapLatest {
      self.googleUseCase.requestGeocoding(addrsss: $0)
        .map { $0.results.first ?? GeocoderResult(address: "", geometry: nil) }
        .asDriver(onErrorJustReturn: GeocoderResult(address: "", geometry: nil))
    }
    .do(onNext: { self.geocoderSubject.onNext($0) })
    .do(onNext: { log.debug($0) })


    let keyboardHeight = input.keyboardWillShowTrigger
      .map { $0.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect }
      .map { $0?.height ?? 0.0 }
      .asDriver(onErrorJustReturn: 0.0)

    let keyboardDidHide = input.keyboardWillHideTrigger
      .mapToVoid()
      .asDriver(onErrorJustReturn: ())

    let navigateToRegistry = input.selectedAddress
      .map { _ in
//        navigator.navigate(to: .registry)
    }


    return Output(
      popViewController: popViewController,
      locationStart: starting,
      locationUpdate: fetching,
      searchedGeocoder: didSearch,
      keyboardHeight: keyboardHeight,
      keyboardDidHide: keyboardDidHide
    )
  }
}
