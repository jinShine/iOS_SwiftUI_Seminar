//
//  SJSearchBar.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/19.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class SJSearchBar: UIControl {
  
  private struct Constant {
    static let basicMargin: CGFloat = 16.0
    static let textFieldLeftMargin: CGFloat = 60.0
//    static let layerCornerRadius: CGFloat = 18.0
  }
  
  private let searchBaseView: UIImageView = {
    let imageView = UIImageView()
    let image = UIImage(named: "SearchBar")
    imageView.image = image
    imageView.contentMode = .scaleAspectFit
    imageView.isUserInteractionEnabled = true
    return imageView
  }()
  
  lazy var textField: UITextField = {
    let textField = UITextField()
    textField.clearButtonMode = .whileEditing
    textField.returnKeyType = .search
    return textField
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupUI() {
    
    textField.delegate = self
    
    [searchBaseView].forEach { self.addSubview($0) }
    [textField].forEach { searchBaseView.addSubview($0) }

    searchBaseView.translatesAutoresizingMaskIntoConstraints = false
    textField.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      searchBaseView.topAnchor.constraint(equalTo: self.topAnchor),
      searchBaseView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      searchBaseView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      searchBaseView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
      
      textField.centerYAnchor.constraint(equalTo: searchBaseView.centerYAnchor),
      textField.leadingAnchor.constraint(equalTo: searchBaseView.leadingAnchor, constant: Constant.textFieldLeftMargin),
      textField.trailingAnchor.constraint(equalTo: searchBaseView.trailingAnchor, constant: -Constant.basicMargin)
    ])
  }
}

extension SJSearchBar: UITextFieldDelegate {}
