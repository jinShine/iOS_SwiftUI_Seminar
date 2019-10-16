//
//  SplashViewController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {

  //MARK: - UI Properties
  
  
  //MARK: - Properties
  var splashNavigator: SplashNavigator?

  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupUI()
    setupNavigator()
    let dd = LocationManager()
    
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.splashNavigator?.navigate(to: .home)
    }

  }
  
  //MARK: - Methods
  private func setupUI() {
    self.view.backgroundColor = .red
  }

  private func setupNavigator() {
    splashNavigator = SplashNavigator(with: self.navigationController)
  }

}
