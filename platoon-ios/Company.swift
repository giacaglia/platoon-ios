//
//  Company.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/25/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import Foundation
import RealmSwift

class Company : Object {
    dynamic var id     = 0
    dynamic var name   = ""
    dynamic var rating = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}