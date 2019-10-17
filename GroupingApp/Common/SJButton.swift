//
//  SJButton.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/17.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class SJButton: UIButton {
  
  let lbTitle: UILabel = {
    let label = UILabel()
    label.textAlignment = .left
    label.textColor = .white
    label.font = App.font.bold(size: 16)
    return label
  }()
  
  let ivLogo: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  convenience init(title: String, image: UIImage?) {
    self.init()
    setupUI()
    
    lbTitle.text = title
    ivLogo.image = image
  }
  
  private func setupUI() {
    
    setBackgroundImage(UIImage(named: "Button_Background"), for: .normal)
    
    [lbTitle, ivLogo].forEach {
      self.addSubview($0)
    }
    
    lbTitle.translatesAutoresizingMaskIntoConstraints = false
    ivLogo.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      lbTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
      lbTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      lbTitle.trailingAnchor.constraint(equalTo: ivLogo.leadingAnchor, constant: -16),
      ivLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
      ivLogo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
      ivLogo.widthAnchor.constraint(equalToConstant: 20),
      ivLogo.heightAnchor.constraint(equalToConstant: 20)
    ])
  }
}
