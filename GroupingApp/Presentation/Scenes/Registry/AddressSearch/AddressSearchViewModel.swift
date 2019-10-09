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
    case didTapPop
    case didSearch(address: String)
    case didTapCell(indexPath: IndexPath)
  }
  
  enum Action {
    case didTapPopAction
    case didSearchAction(address: String)
    case didTapCellAction(indexPath: IndexPath)
  }
  
  enum State {
    case didTapPopState
    case didSearchState(viewModel: [SearchSection])
    case didTapCellState(selectedItem: PlaceModel)
  }
  
  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()
  var placeList: [PlaceModel] = []
  
  
  //MARK: - Properties
  let naverUseCase: NaverUseCase
  
  
  //MARK: - Initialize
  init(naverUseCase: NaverUseCase) {
    self.naverUseCase = naverUseCase
    
    self.bind()
  }
  
  
  //MARK: - Unidirection Action
  
  func toAction(from command: Command) -> Observable<Action> {
    switch command {
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
    case .didTapPopAction:
      return Observable<State>.just(.didTapPopState)
      
    case .didSearchAction(let address):
      return naverUseCase.requestAddress(address: address)
        .asObservable()
        .observeOn(ConcurrentDispatchQueueScheduler(qos: .default))
        .map { addressModel in
          self.placeList = addressModel.places
          return addressModel.places.map {
            SearchSectionItem.addressItem(cellViewModel: AddressCellViewModel(item: $0))
          }
        }
        .map { [SearchSection.address(title: "", items: $0)] }
        .flatMap { Observable<State>.just(.didSearchState(viewModel: $0)).retry(3) }
        .catchErrorJustReturn(.didSearchState(viewModel: []))
      
    case .didTapCellAction(let indexPath):
      return Observable<State>.just(.didTapCellState(selectedItem: placeList[indexPath.row]))
    }
  }
}

//MARK: - Method Handler
extension AddressSearchViewModel {
  
}
