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

    let window = UIApplication.shared.windows.first { $0.isKeyWindow }
    
    let baseView = UIView()
    baseView.backgroundColor = .clear
    
    [baseView].forEach { view.addSubview($0)}
    [leftItem, titleItem, rightItem].forEach { baseView.addSubview($0) }
    
    // Base View
    baseView.translatesAutoresizingMaskIntoConstraints = false
    if #available(iOS 13.0, *) {
      let statusBarManager = window?.windowScene?.statusBarManager
      NSLayoutConstraint.activate([
        baseView.topAnchor.constraint(equalTo: view.topAnchor),
        baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        baseView.heightAnchor.constraint(equalToConstant: Constant.itemSize + (statusBarManager?.statusBarFrame.height ?? 0))
      ])
    } else {
      NSLayoutConstraint.activate([
        baseView.topAnchor.constraint(equalTo: view.topAnchor),
        baseView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
        baseView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        baseView.heightAnchor.constraint(equalToConstant: Constant.itemSize + UIApplication.shared.statusBarFrame.height)
      ])
    }
    
    // Left Item
    leftItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      leftItem.leadingAnchor.constraint(equalTo: baseView.leadingAnchor, constant: Constant.basicMargin),
      leftItem.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
      leftItem.heightAnchor.constraint(equalToConstant: Constant.itemSize),
      leftItem.widthAnchor.constraint(equalToConstant: Constant.itemSize)
    ])
    
    // Right Item
    rightItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      rightItem.trailingAnchor.constraint(equalTo: baseView.trailingAnchor, constant: -Constant.basicMargin),
      rightItem.bottomAnchor.constraint(equalTo: baseView.bottomAnchor),
      rightItem.heightAnchor.constraint(equalToConstant: Constant.itemSize),
      rightItem.widthAnchor.constraint(equalToConstant: Constant.itemSize)
    ])
    
    // Title Item
    titleItem.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      titleItem.leadingAnchor.constraint(equalTo: leftItem.trailingAnchor, constant: Constant.basicMargin),
      titleItem.trailingAnchor.constraint(equalTo: rightItem.leadingAnchor, constant: -Constant.basicMargin),
      titleItem.centerXAnchor.constraint(equalTo: baseView.centerXAnchor),
      titleItem.centerYAnchor.constraint(equalTo: leftItem.centerYAnchor)
    ])
  }
}
