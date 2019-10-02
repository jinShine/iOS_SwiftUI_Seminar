//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {


  //MARK: Properties



  //MARK: UI Properties



  //MARK: Initialization

  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  deinit {
    print("DEINIT: \(String(describing: self))")
  }


  //MARK: Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = App.color.background
    
  }

  func naviLeftBarButton(name: String) -> UIButton {
    let image = UIImage(named: name)
    let button = UIButton()
    button.setImage(image, for: .normal)
    button.contentMode = .scaleAspectFit
    view.addSubview(button)

    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
      button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
      button.heightAnchor.constraint(equalToConstant: 44),
      button.widthAnchor.constraint(equalToConstant: 44)
    ])

    return button
  }

  func naviRightBarButton(name: String) -> UIButton {
    let image = UIImage(named: name)
    let button = UIButton()
    button.setImage(image, for: .normal)
    button.contentMode = .scaleAspectFit
    view.addSubview(button)

    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.topAnchor.constraint(equalTo: view.topAnchor, constant: 54),
      button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
      button.heightAnchor.constraint(equalToConstant: 44),
      button.widthAnchor.constraint(equalToConstant: 44)
    ])

    return button
  }

}
