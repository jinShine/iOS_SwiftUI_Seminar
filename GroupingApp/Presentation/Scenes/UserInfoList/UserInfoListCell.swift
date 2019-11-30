//
//  UserInfoListCell.swift
//  GroupingApp
//
//  Created by seungjin on 2019/11/29.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class UserInfoListCell: UITableViewCell {
  
  @IBOutlet weak var baseView: UIView!
  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var addressLabel: UILabel!
  @IBOutlet weak var numberLabel: UILabel!
  @IBOutlet weak var crewLabel: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    baseView.layer.applyShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4)
    baseView.layer.cornerRadius = 15
    baseView.layer.masksToBounds = true
    
    crewLabel.layer.cornerRadius = 6
    crewLabel.layer.masksToBounds = true
    crewLabel.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    
  }
  
}
