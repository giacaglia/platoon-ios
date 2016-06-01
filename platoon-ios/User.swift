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
    dynamic var first_name = ""
    dynamic var last_name = ""
    dynamic var phone_number = ""
    dynamic var truck_type = ""
    dynamic var plate_number = ""
    dynamic var image = ""
    
}