//
//  AddressSearchViewController+TableViewDecorator.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/07.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

//MARK: - UITableView Datasource
extension AddressSearchViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return addressList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell: UITableViewCell!
    switch indexPath.section {
    case ModelType.address.hashValue:
      cell = tableView.dequeueReusableCell(withIdentifier: AddressCell.resuseIdentifier)
      
    default:
      return cell
    }
    cell = tableView.dequeueReusableCell(withIdentifier: )
    guard let addressCell = tableView.dequeueReusableCell(withIdentifier: AddressCell.resuseIdentifier, for: indexPath) as? AddressCell else { return UITableViewCell() }
    
    tableView.dequeueReusableCell(withIdentifier: reuseIdentifierForCell(type: <#T##AddressSearchViewController.ModelType#>))
    
    if let viewModel = object(at: indexPath) as? AddressCellViewModel {
      addressCell.viewModel = viewModel
    }
    
    return addressCell
  }
  
  private func object(at indexPath: IndexPath) -> Any? {
    guard indexPath.row < addressList.count else {
      return nil
    }
    
    let item = addressList[indexPath.row]
    return AddressCellViewModel(item: item)
  }
}

//MARK: - UITableView Delegate
extension AddressSearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = addressList[indexPath.row]
    navigator.navigate(to: .selectMap(selectedItem))
  }
}

//MARK: - TableView Decorator
extension AddressSearchViewController: TableViewDecorator {
  
  func reuseIdentifierForCell(type: ModelType) -> String {
    var reuseIdentifier = ""
    switch type {
    case .address:
      reuseIdentifier = AddressCell.resuseIdentifier
    }
    
    return reuseIdentifier
    
  }
  
  func configureCell(cell: UITableViewCell, type: ModelType, object: Any) {
    switch type {
    case .address:
      configureAddressCell(cell, type: type, object: object)
    }
  }
  
  func configureAddressCell(_ cell: UITableViewCell, type: ModelType, object: Any) {
    
  }
  
}
