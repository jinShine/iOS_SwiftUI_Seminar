//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import SnapKit

enum TabBarType: Int {
  case Home = 0,
  Registery,
  Search
}

class BaseTabBarController: UITabBarController {
  
  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    delegate = self
    
    // Shadow
    tabBarClear()
    tabBar.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: -2, blur: 16)
    
    // Item Image Inset
    tabBar.items?.forEach {
      $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
  }
  
  private func tabBarClear() {
    let appearance = UITabBar.appearance()
    appearance.shadowImage = UIImage()
    appearance.backgroundImage = UIImage()
    appearance.backgroundColor = .white
  }
  
  private func makeRegistry() -> UINavigationController {
    let viewModel = RegistryViewModel(userUseCase: UserInteractor())
    let viewController = RegistryViewController(viewModel: viewModel)
    return UINavigationController(rootViewController: viewController)
  }
  
}


//MARK: - UITabBar Delegate
extension BaseTabBarController: UITabBarControllerDelegate {
  
  func tabBarController(_ tabBarController: UITabBarController,
                        shouldSelect viewController: UIViewController) -> Bool {
    
    let selectedVCIndex = tabBarController.viewControllers?.firstIndex(of: viewController)
    if selectedVCIndex == TabBarType.Registery.rawValue {
      let registryVC = makeRegistry()
      registryVC.modalPresentationStyle = .fullScreen
      self.present(registryVC, animated: true, completion: nil)
      return false
    }
    
    return true
  }
}


//MARK: - UITabbr
extension UITabBar {
  
  struct Constant {
    static let tabBarHeight: CGFloat = 70
  }
  
  // TabBar Height 조절 방법
  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    super.sizeThatFits(size)
    let tabBarHeight: CGFloat = Constant.tabBarHeight + (window?.safeAreaInsets.bottom ?? 0)
    
    var sizeThatFits = super.sizeThatFits(size)
    sizeThatFits.height = tabBarHeight
    
    return sizeThatFits
  }
  
}
