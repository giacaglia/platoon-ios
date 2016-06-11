//
//  User.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import Foundation
import RealmSwift


class User : Object {
    dynamic var id           = 0
    dynamic var firstName   = ""
    dynamic var lastName    = ""
    dynamic var phoneNumber = ""
    dynamic var truckType   = ""
    dynamic var plateNumber = ""
    dynamic var image        = ""
    
    func fullName() -> String {
        return firstName + " " + lastName
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
}