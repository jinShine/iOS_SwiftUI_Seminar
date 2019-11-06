//
//  AddressSearchNavigator.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import FlowInject

enum AddressSearch: Route {
  case registry(address: String?)
}

class AddressSearchNavigator: Navigator<AddressSearch> {
  
  func navigate(to destination: AddressSearch) {
    switch destination {
    case .registry(let address):
      let registryVC = presenter?.viewControllers.first { $0 is RegistryViewController } as? RegistryViewController
      registryVC?.viewModel.receivedAddress = address
      presenter?.popViewController(animated: true)
    }
  }
  
}
