//
//  LoadingView.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/20.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

protocol Loadable {
  func show()
  func hide()
}

final class LoadingView: Loadable {

  static let shared = LoadingView()
  private let keyWindow = App.window!
  private var backgroundView = UIView()
  private var logoImages = UIImageView()
  
  init() {
    setupBackgroundView()
    setupLogoImage()
  }
  
  func show() {
    startAnimating()
  }
  
  func hide() {
    stopAnimating()
    backgroundView.removeFromSuperview()
    logoImages.removeFromSuperview()
  }
  
  private func getImageList() -> [UIImage] {
    return [
      UIImage(named: "logo1"),
      UIImage(named: "logo2"),
      UIImage(named: "logo3"),
      UIImage(named: "logo4"),
      UIImage(named: "logo5"),
      UIImage(named: "logo6"),
      UIImage(named: "logo7"),
      UIImage(named: "logo8"),
      UIImage(named: "logo9"),
      UIImage(named: "logo10"),
    ].compactMap{ $0 }
  }
  
  private func setupBackgroundView() {
    keyWindow.addSubview(backgroundView)
    backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
    backgroundView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: keyWindow.topAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: keyWindow.leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: keyWindow.trailingAnchor),
      backgroundView.bottomAnchor.constraint(equalTo: keyWindow.bottomAnchor)
    ])
  }
  
  private func setupLogoImage() {
    keyWindow.addSubview(logoImages)
    logoImages.animationImages = getImageList()
    logoImages.animationDuration = 0.5
    logoImages.animationRepeatCount = 0
    logoImages.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      logoImages.centerYAnchor.constraint(equalTo: keyWindow.centerYAnchor),
      logoImages.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor),
      logoImages.heightAnchor.constraint(equalToConstant: 96),
      logoImages.widthAnchor.constraint(equalToConstant: 96)
    ])
  }
  
  private func startAnimating() {
    logoImages.startAnimating()
  }
  
  private func stopAnimating() {
    logoImages.stopAnimating()
  }
}
