//
//  BaseTarBarController.swift
//  GroupingApp
//
//  Created by Seungjin on 01/10/2019.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import Loaf

class BaseViewController: UIViewController {

  //MARK: - Constant
  struct Constant {
    static let itemSize: CGFloat = 44
    static let basicMargin: CGFloat = 12
  }

  //MARK: - Properties



  //MARK: - UI Properties
  
  let navigationBaseView = UIView()
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }


  //MARK: - Initialization

  init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
    print("DEINIT: \(String(describing: self))")
  }
  

  //MARK: - Life Cycle

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = App.color.background
    navigationController?.interactivePopGestureRecognizer?.delegate = self
  }

}

//MARK: - Methods
extension BaseViewController {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    dismissKeyboard()
  }
  
  func addDismissTabGesture(in view: UIView) {
    let dismissKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    dismissKeyboardGesture.numberOfTapsRequired = 1
    dismissKeyboardGesture.isEnabled = true
    dismissKeyboardGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(dismissKeyboardGesture)
  }
  
  @objc func dismissKeyboard() {
    self.view.endEditing(true)
  }
  
}

//MARK: - GestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
  func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                         shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
    return true
  }
}
