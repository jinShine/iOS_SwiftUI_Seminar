//
//  UserInfoListCell.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/29.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class UserInfoListCell: UITableViewCell {
  
  private struct Constant {
    static let profileImageViewSize: CGFloat = 56
  }
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var crewLabel: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()

    self.layer.applyShadow(color: .black, alpha: 0.2, x: 0, y: 2, blur: 4)
    baseView.layer.cornerRadius = 15
    baseView.layer.masksToBounds = true
    
    profileImageView.layer.cornerRadius = Constant.profileImageViewSize / 2
    profileImageView.layer.masksToBounds = true
    profileImageView.contentMode = .scaleAspectFill
    
    nameLabel.font = App.font.bold(size: 14)
    addressLabel.font = App.font.regular(size: 14)
    
    numberLabel.font = App.font.regular(size: 14)
    
    crewLabel.titleLabel?.font = App.font.regular(size: 14)
    crewLabel.layer.cornerRadius = 6
    crewLabel.layer.masksToBounds = true
    crewLabel.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
  }
}
