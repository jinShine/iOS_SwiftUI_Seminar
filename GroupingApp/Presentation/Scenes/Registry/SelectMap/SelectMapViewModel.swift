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
//    case bindPlaceData
  }

  enum Action {

  }

  enum State {
//    case bindPlaceDataState(plceInfo: Geocoder)
  }

  var command = PublishSubject<Command>()
  var state = Driver<State>.empty()
  var stateSubject = PublishSubject<State>()




  //MARK: - Properties

  let geocoderModel: GeocoderResult


  //MARK: - Initialize
  init(geocoderModel: GeocoderResult) {
    self.geocoderModel = geocoderModel
    
    self.bind()
  }


  //MARK: - Unidirection Action

  func toAction(from command: Command) -> Observable<Action> {
    switch command {
//    case .bindPlaceData:
//      return Observable<Action>.empty()
//      return Observable<Action>.just(.bindPlaceDataAction)
    }
  }

  func toState(from action: Action) -> Observable<State> {
    switch action {
//    case .bindPlaceDataAction:
//      return Observable<State>.empty()
//      return Observable<State>.just(.bindPlaceDataState(geocodeInfo: geocoderModel))
    }
  }

}

//MARK: - Method Handler
extension SelectMapViewModel {


}
