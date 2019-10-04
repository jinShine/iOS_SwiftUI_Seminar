//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import SnapKit

enum TabBarViewControllers: Int {
  case Home = 0
  case Registery
  case Search
}

class BaseTabBarController: UITabBarController {

  //MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
  }
  
  private func setupUI() {
    delegate = self
    
    tabBarClear()
    tabBar.layer.applyShadow(color: .black, alpha: 0.16, x: 0, y: -2, blur: 16)
    
    tabBar.items?.forEach {
      $0.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    
  }

  func tabBarClear() {
    let appearance = UITabBar.appearance()
    appearance.shadowImage = UIImage()
    appearance.backgroundImage = UIImage()
    appearance.backgroundColor = .white
  }
  
  private func makeRegistry() -> UINavigationController {
    let registryViewModel = RegistryViewModel(userUseCase: UserInteractor())
    let registryVC = RegistryViewController(viewModel: registryViewModel)
    return UINavigationController(rootViewController: registryVC)
  }

}


//MARK: - UITabBar Delegate
extension BaseTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        
    let selectedVCIndex = tabBarController.viewControllers?.firstIndex(of: viewController)
    if selectedVCIndex == TabBarViewControllers.Registery.rawValue {
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

  private struct Constant {
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


//MARK: - CALayer
//Sketch 스타일
extension CALayer {
  func applyShadow (
    color: UIColor = .black,
    alpha: Float = 0.5,
    x: CGFloat = 0,
    y: CGFloat = 2,
    blur: CGFloat = 4
  ) {
    shadowColor = color.cgColor
    shadowOpacity = alpha
    shadowOffset = CGSize(width: x, height: y)
    shadowRadius = blur / 2.0
  }
}
