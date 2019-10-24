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
  }
  
  struct Output {
    let popViewController: Driver<Void>
    let locationStart: Driver<Void>
    let locationUpdate: Driver<LocationResponse>
    let searchedGeocoder: Driver<GeocoderResult>
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

    let popViewController = input.didTapPopButton
      .map { self.navigator.navigate(to: .registry)
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
    }.do(onNext: { log.debug($0) })


    return Output(
      popViewController: popViewController,
      locationStart: starting,
      locationUpdate: fetching,
      searchedGeocoder: didSearch
    )
  }
}
//  //MARK: - Unidirection
//
//  enum Command {
//    case locationStart
//    case locationStop
//    case locationFetch
//    case didTapPop
//    case didSearch(address: String)
//    case keyboardWillShow(Notification)
//    case keyboardWillHide
//  }
//
//  enum Action {
//    case locationStartAction
//    case locationStopAction
//    case locationFetchAction
//    case didTapPopAction
//    case didSearchAction(address: String)
//    case keyboardWillShowAction(Notification)
//    case keyboardWillHideAction
//  }
//
//  enum State {
//    case locationStartState
//    case locationStopState
//    case locationFetchState(LocationResponse)
//    case didTapPopState
//    case didSearchState(result: GeocoderResult)
//    case keyboardWillShowState(CGFloat)
//    case keyboardWillHideState
//  }
//
//  var command = PublishSubject<Command>()
//  var state = Driver<State>.empty()
//  var stateSubject = PublishSubject<State>()
//  private var geocoderData = GeocoderResult(address: "", geometry: nil)
//
//
//  //MARK: - Properties
//  let googleUseCase: GoogleUseCase
//  let locationUseCase: LocationUseCase
//
//
//  //MARK: - Initialize
//  init(googleUseCase: GoogleUseCase, locationUseCase: LocationUseCase) {
//    self.googleUseCase = googleUseCase
//    self.locationUseCase = locationUseCase
//
//    self.bind()
//  }
//
//
//  //MARK: - Unidirection Action
//
//  func toAction(from command: Command) -> Observable<Action> {
//    switch command {
//    case .locationStart:
//      return Observable<Action>.just(.locationStartAction)
//    case .locationStop:
//      return Observable<Action>.just(.locationStopAction)
//    case .locationFetch:
//      return Observable<Action>.just(.locationFetchAction)
//    case .didTapPop:
//      return Observable<Action>.just(.didTapPopAction)
//    case .didSearch(let address):
//      return Observable<Action>.just(.didSearchAction(address: address))
//    case .keyboardWillShow(let noti):
//      return Observable<Action>.just(.keyboardWillShowAction(noti))
//    case .keyboardWillHide:
//      return Observable<Action>.just(.keyboardWillHideAction)
//    }
//  }
//
//  func toState(from action: Action) -> Observable<State> {
//    switch action {
//    case .locationStartAction:
//      return locationUseCase.start().asObservable()
//        .flatMap { _ in Observable<State>.just(.locationStartState) }
//
//    case .locationStopAction:
//      return locationUseCase.stop().asObservable()
//        .flatMap { _ in Observable<State>.just(.locationStopState) }
//
//    case .disAction:
//      return locationUseCase.fetch().flatMap { (location, error) in
//        return Observable<State>.just(.locationFetchState((location, error)))
//      }
//
//    case .didTapPopAction:
//      return Observable<State>.just(.didTapPopState)
//
//    case .didSearchAction(let address):
//      log.debug(address)
//      return googleUseCase.requestGeocoding(addrsss: address)
//        .asObservable()
//        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
//        .map { geocoder in
//          if let result = geocoder.results.first {
//            self.geocoderData = result
//            return result
//          }
//          return GeocoderResult(address: "", geometry: nil)
//        }
//        .flatMap { Observable<State>.just(.didSearchState(result: $0)).retry(3) }
//
//    case .keyboardWillShowAction(let noti):
//      let keyboardFrame = noti.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
//      let keyboardHeight = keyboardFrame?.height
//      return Observable<State>.just(.keyboardWillShowState(keyboardHeight ?? 0))
//
//    case .keyboardWillHideAction:
//      return Observable<State>.just(.keyboardWillHideState)
//    }
//  }
//}
//
////MARK: - Method Handler
//extension AddressSearchViewModel {
//  func getGeocoder() -> GeocoderResult {
//    return geocoderData
//  }
//}
