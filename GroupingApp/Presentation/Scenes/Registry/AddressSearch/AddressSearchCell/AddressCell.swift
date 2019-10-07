//
//  AddressCell.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/06.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

  @IBOutlet weak var mapPin: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var jibunAddressLabel: UILabel!
  @IBOutlet weak var roadAddressLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
        
    setupUI()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
  }
  
  private func setupUI() {

    mapPin.image = UIImage(named: "Icon-Map-Pin")
    
    self.titleLabel.textColor = .black
    self.titleLabel.font = App.font.regular(size: 14)
    
    self.jibunAddressLabel.textColor = .lightGray
    self.jibunAddressLabel.font = App.font.regular(size: 12)
    
    self.roadAddressLabel.textColor = .lightGray
    self.roadAddressLabel.font = App.font.regular(size: 12)
  }
  
  var viewModel: AddressCellViewModel! {
    didSet {
      self.titleLabel.text = viewModel.name
      
      if let address = viewModel.jibun_address {
        if address != "" {
          self.jibunAddressLabel.text = "[지번] " + address
        } else {
          self.jibunAddressLabel.text = ""
        }
      }
      
      if let roadAddress = viewModel.road_address {
        if roadAddress != "" {
          self.roadAddressLabel.text = "[도로명] " + roadAddress
        } else {
          self.roadAddressLabel.text = ""
        }
      }
    }
  }
    
}
