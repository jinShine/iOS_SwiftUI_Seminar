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

  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.numberOfSections()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection(section: section)
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell: UITableViewCell!
    if let userInfo = viewModel.listObject(at: indexPath) as? [AnyHashable : Any] {
      let (type, object) = self.viewModel.objectFromUserInfo(userInfo: userInfo)
      cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifierForCell(type: type))
      self.configureCell(cell: cell, type: type, object: object)
    }
    return cell
  }
}

//MARK: - UITableView Delegate
extension AddressSearchViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedItem = viewModel.list[indexPath.row]
//    navigator.navigate(to: .selectMap([selectedItem))
  }
}

//MARK: - TableView Decorator
extension AddressSearchViewController: TableViewDecorator {

  func reuseIdentifierForCell(type: AnyHashable) -> String {
    var reuseIdentifier = ""
    if let modelType = type.base as? AddressSearchViewModel.ModelType {
      switch modelType {
      case .address:
        reuseIdentifier = AddressCell.reuseIdentifier
      }
    }

    return reuseIdentifier
  }

  func configureCell(cell: UITableViewCell, type: AnyHashable, object: Any) {
    if let modelType = type.base as? AddressSearchViewModel.ModelType {
      switch modelType {
      case .address:
        guard let cell = cell as? AddressCell,
          let vm = object as? AddressCellViewModel else {
            return
        }

        cell.viewModel = vm
      }
    }
  }
}
