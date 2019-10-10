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
    
    self.jibunAddressLabel.textColor = .black
    self.jibunAddressLabel.font = App.font.regular(size: 14)
    
    self.roadAddressLabel.textColor = App.color.sub
    self.roadAddressLabel.font = App.font.regular(size: 12)
  }
  
  var viewModel: AddressCellViewModel! {
    didSet {
      self.jibunAddressLabel.text = viewModel.address
//      self.roadAddressLabel.text = viewModel.
    }
  }

}
