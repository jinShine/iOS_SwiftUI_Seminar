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
    case didSearchState(AddressModel)
  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




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
      
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .didTapPopAction:
      return Observable<State>.just(.didTapPopState)
    case .didSearchAction(let address):
      print(" :", address)
      return naverUseCase.requestAddress(address: address)
        .flatMap { addressModel in
          return Observable<State>.just(.didSearchState(addressModel))
      }
      
    }
  }

}

//MARK: - Method Handler
extension AddressSearchViewModel {


}
