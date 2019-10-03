//
//  UserInfomation+CoreDataProperties.swift
//  GroupingApp
//
//  Created by seungjin on 2019/10/03.
//  Copyright © 2019 Jinnify. All rights reserved.
//
//

import Foundation
import CoreData


extension UserInfomation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfomation> {
        return NSFetchRequest<UserInfomation>(entityName: "UserInfomation")
    }

    @NSManaged public var address: String?
    @NSManaged public var birth: String?
    @NSManaged public var crew: String?
    @NSManaged public var email: String?
    @NSManaged public var memo: String?
    @NSManaged public var name: String?
    @NSManaged public var number: String?

}
