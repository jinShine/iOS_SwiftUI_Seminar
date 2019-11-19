//
//  UIViewController+NavigationBar.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

extension BaseViewController {
  
  func setupNavigationBar(at view: UIView,
                          leftItem: UIButton = UIButton(),
                          titleItem: UIView = UIView(),
                          rightItem: UIButton = UIButton()) {
    
    [navigationBaseView].forEach { view.addSubview($0)}
    [leftItem, titleItem, rightItem].forEach { navigationBaseView.addSubview($0) }
    
    // Base View
    navigationBaseView.translatesAutoresizingMaskIntoConstraints = false
    if #available(iOS 13.0, *) {
      let statusBarManager = App.window?.windowScene?.statusBarManager
      NSLayoutConstraint.activate([
        navigationBaseView.topAnchor.constraint(equalTo: view.topAnchor),
        navigationBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        navigationBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        navigationBaseView.heightAnchor.constraint(equalToConstant: Constant.itemSize + (statusBarManager?.statusBarFrame.height ?? 0))
      ])
    } else {
      NSLayoutConstraint.activate([
        navigationBaseView.topAnchor.constraint(equalTo: view.topAnchor),
        navigationBaseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        navigationBaseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        navigationBaseView.heightAnchor.constraint(equalToConstant: Constant.itemSize + UIApplication.shared.statusBarFrame.height)
      ])
    }
    
    // Left Item
    leftItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leftItem.leadingAnchor.constraint(equalTo: navigationBaseView.leadingAnchor, constant: Constant.basicMargin),
      leftItem.bottomAnchor.constraint(equalTo: navigationBaseView.bottomAnchor),
      leftItem.heightAnchor.constraint(equalToConstant: Constant.itemSize),
      leftItem.widthAnchor.constraint(equalToConstant: Constant.itemSize)
    ])
    
    // Right Item
    rightItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      rightItem.trailingAnchor.constraint(equalTo: navigationBaseView.trailingAnchor, constant: -Constant.basicMargin),
      rightItem.bottomAnchor.constraint(equalTo: navigationBaseView.bottomAnchor),
      rightItem.heightAnchor.constraint(equalToConstant: Constant.itemSize),
      rightItem.widthAnchor.constraint(equalToConstant: Constant.itemSize)
    ])
    
    // Title Item
    titleItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleItem.leadingAnchor.constraint(equalTo: leftItem.trailingAnchor, constant: Constant.basicMargin),
      titleItem.trailingAnchor.constraint(equalTo: rightItem.leadingAnchor, constant: -Constant.basicMargin),
      titleItem.centerXAnchor.constraint(equalTo: navigationBaseView.centerXAnchor),
      titleItem.centerYAnchor.constraint(equalTo: leftItem.centerYAnchor)
    ])
  }
}
