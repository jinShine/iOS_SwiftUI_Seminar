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
  }

  enum Action {
    case didTapPopAction
    case didSearchAction(address: String)
  }

  enum State {
    case didTapPopState
    case didSearchState
  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




  //MARK: - Properties

  let naverUseCase: NaverUseCase
  var list: [[ModelType : Any]] = []
  
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
      
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .didTapPopAction:
      return Observable<State>.just(.didTapPopState)
      
    case .didSearchAction(let address):
      return naverUseCase.requestAddress(address: address)
        .asObservable()
        .map { self.list = $0.places.map{[ModelType.address : AddressCellViewModel(item: $0)] }}
        .flatMap { Observable<State>.just(.didSearchState).retry(3) }
        .catchErrorJustReturn(.didSearchState)
    }
  }
}

//MARK: - Method Handler
extension AddressSearchViewModel {

}

//MARK: - TableView DataSource ViewModel
extension AddressSearchViewModel: TableViewDataSourceViewModel {
  func numberOfRowsInSection(section: Int) -> Int {
    return list.count
  }

  func numberOfSections() -> Int {
    return 1
  }

  func listObject(at indexPath: IndexPath) -> Any? {
    guard indexPath.row < list.count else { return nil }

    return list[indexPath.row]
  }
}
