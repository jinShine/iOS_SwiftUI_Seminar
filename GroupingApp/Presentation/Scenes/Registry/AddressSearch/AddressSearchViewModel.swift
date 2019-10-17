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
  
  
  enum ModelType: Int {
    case address = 0
  }
  
  //MARK: - Constant
  
  struct Constant {
    
  }
  
  
  //MARK: - Unidirection
  
  enum Command {
    case locationStart
    case locationStop
    case locationFetch
    case didTapPop
    case didSearch(address: String)
    case didTapCell(indexPath: IndexPath)
  }
  
  enum Action {
    case locationStartAction
    case locationStopAction
    case locationFetchAction
    case didTapPopAction
    case didSearchAction(address: String)
    case didTapCellAction(indexPath: IndexPath)
  }
  
  enum State {
    case locationStartState
    case locationStopState
    case locationFetchState(LocationResponse)
    case didTapPopState
    case didSearchState(viewModel: [SearchSection])
    case didTapCellState(selectedItem: GeocoderResult)
  }
  
  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()
  var geocodeList: [GeocoderResult] = []


  //MARK: - Properties
  let googleUseCase: GoogleUseCase
  let locationUseCase: LocationUseCase
  
  
  //MARK: - Initialize
  init(googleUseCase: GoogleUseCase, locationUseCase: LocationUseCase) {
    self.googleUseCase = googleUseCase
    self.locationUseCase = locationUseCase
    
    self.bind()
  }
  
  
  //MARK: - Unidirection Action
  
  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .locationStart:
      return Observable<Action>.just(.locationStartAction)
    case .locationStop:
      return Observable<Action>.just(.locationStopAction)
    case .locationFetch:
      return Observable<Action>.just(.locationFetchAction)
    case .didTapPop:
      return Observable<Action>.just(.didTapPopAction)
    case .didSearch(let address):
      return Observable<Action>.just(.didSearchAction(address: address))
    case .didTapCell(let indexPath):
      return Observable<Action>.just(.didTapCellAction(indexPath: indexPath))
    }
  }
  
  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .locationStartAction:
      return locationUseCase.start().asObservable()
        .flatMap { _ in Observable<State>.just(.locationStartState) }
      
    case .locationStopAction:
      return locationUseCase.stop().asObservable()
        .flatMap { _ in Observable<State>.just(.locationStopState) }
      
    case .locationFetchAction:
      return locationUseCase.fetch().flatMap { (location, error) in
        return Observable<State>.just(.locationFetchState((location, error)))
      }
      
    case .didTapPopAction:
      return Observable<State>.just(.didTapPopState)
      
    case .didSearchAction(let address):
      return googleUseCase.requestGeocoding(addrsss: address)
        .asObservable()
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map { geocoder in
          //TODO: Error Handling

          self.geocodeList = geocoder.results

          return geocoder.results.map { result in
            SearchSectionItem.addressItem(cellViewModel: AddressCellViewModel(item: result))
          }
        }
        .map { [SearchSection.address(title: "", items: $0)] }
        .flatMap { Observable<State>.just(.didSearchState(viewModel: $0)).retry(3) }
        .catchErrorJustReturn(.didSearchState(viewModel: []))

    case .didTapCellAction(let indexPath):
      return Observable<State>.just(.didTapCellState(selectedItem: geocodeList[indexPath.row]))
    }
  }
}

//MARK: - Method Handler
extension AddressSearchViewModel {
  
}
