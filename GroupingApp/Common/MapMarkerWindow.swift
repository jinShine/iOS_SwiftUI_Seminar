//
//  MapMarkerWindow.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/19.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit
import RxSwift

class MapMarkerWindow: UIView {
  
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var addButton: UIButton!

  public var addSubject = PublishSubject<UIButton>()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupUI()
  }
  
  private func setupUI() {
    self.alpha = 0.9
    self.layer.cornerRadius = 12
    self.layer.borderWidth = 2
    self.layer.borderColor = App.color.main.cgColor
    self.backgroundColor = .white
  }

  @IBAction func add(_ sender: UIButton) {
    print("1231231231231231231231231231231312123")
    addSubject.onNext(sender)
  }

  static func loadView() -> MapMarkerWindow {
    let infoWindow = MapMarkerWindow.newFromNib() as! MapMarkerWindow
    return infoWindow
  }
}
