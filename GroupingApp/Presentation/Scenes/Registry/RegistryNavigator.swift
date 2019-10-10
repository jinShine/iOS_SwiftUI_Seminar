//
//  RegistryNavigator.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/05.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import FlowInject

enum RegistryRoute: Route {
  case addressSearch
}

class RegistryNavigator: Navigator<RegistryRoute> {
  
  override init(with presenter: UINavigationController?) {
    super.init()
    self.presenter = presenter
  }
  
  func navigate(to destination: RegistryRoute) {
    switch destination {
    case .addressSearch:
      let viewModel = AddressSearchViewModel(googleUseCase: GoogleInteractor())
      let viewController = AddressSearchViewController(viewModel: viewModel, navigator: AddressSearchNavigator(with: presenter))
      presenter?.pushViewController(viewController, animated: true)
    }
  }
  
}
