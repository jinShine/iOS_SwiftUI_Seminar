//
//  SelectMapViewModel.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import RxSwift
import RxCocoa

final class SelectMapViewModel: BindViewModelType {

  //MARK: - Constant

  struct Constant {

  }


  //MARK: - Unidirection

  enum Command {
    case bindPlaceData
  }

  enum Action {
    case bindPlaceDataAction
  }

  enum State {
    case bindPlaceDataState(plceInfo: Addresses)
  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




  //MARK: - Properties

  let placeModel: Addresses


  //MARK: - Initialize
  init(placeModel: Addresses) {
    self.placeModel = placeModel
    
    self.bind()
  }


  //MARK: - Unidirection Action

  func toAction(from command: Command) -> Observable<Action> {
    switch command {
    case .bindPlaceData:
      return Observable<Action>.just(.bindPlaceDataAction)
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
    case .bindPlaceDataAction:
      return Observable<State>.just(.bindPlaceDataState(plceInfo: placeModel))
    }
  }

}

//MARK: - Method Handler
extension SelectMapViewModel {


}
