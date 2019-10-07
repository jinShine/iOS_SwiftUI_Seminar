//
//  TableViewDecorator.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/07.
//  Copyright © 2019 Jinnify. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewDecorator {
  
  func reuseIdentifierForCell(type: ModelType) -> String
  func configureCell(cell: UITableViewCell, type: ModelType, object: Any)
}

