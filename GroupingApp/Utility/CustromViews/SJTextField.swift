//
//  SJTextField.swift
//  GroupingApp
//
//  Created by Seungjin on 04/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import JVFloatLabeledTextField

class SJTextField: JVFloatLabeledTextField {

  //MARK: - Constant
  struct Constant {
    static let placeholderSize: UIFont = App.font.regular(size: 15)
    static let floatingLabelSize: UIFont = App.font.bold(size: 12)
    static let lineHeight: CGFloat = 1
  }

  let line = UIView()

  //MARK: - Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }

  convenience init(placeholder: String? = nil, floating: String? = nil) {
    self.init()
    self.placeholder = placeholder
    self.floatingLabel.text = floating
    if floating == nil {
      self.floatingLabel.text = placeholder
    }
  }


  //MARK: - Methods
  private func setupUI() {

    self.font = Constant.placeholderSize
    self.placeholderColor = App.color.line
    self.floatingLabelFont = Constant.floatingLabelSize
    self.floatingLabelTextColor = App.color.main
    
    line.backgroundColor = App.color.line
    self.addSubview(line)

    line.snp.makeConstraints {
      $0.top.equalTo(self.snp.bottom)
      $0.leading.trailing.equalToSuperview()
      $0.height.equalTo(Constant.lineHeight)
    }

  }

}
