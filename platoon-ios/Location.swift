//
//  Location.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 6/11/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import Foundation
import RealmSwift

class Location : Object {
    dynamic var id            = 0
    dynamic var streetAddress = ""
    dynamic var city          = ""
    dynamic var state         = ""
    dynamic var latitude      = ""
    dynamic var longitude     = ""

    override class func primaryKey() -> String? {
        return "id"
    }
}