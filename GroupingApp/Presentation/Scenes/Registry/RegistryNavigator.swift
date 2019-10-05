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
      let addressSearchViewModel = AddressSearchViewModel(naverUseCase: AddressInteractor())
      let addressSearchVC = AddressSearchViewController(viewModel: addressSearchViewModel)
      presenter?.pushViewController(addressSearchVC, animated: true)
    }
  }
  
}
