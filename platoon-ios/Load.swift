//
//  Load.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/25/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import Foundation
import RealmSwift

class Load : Object {
    dynamic var company = Company()
    dynamic var pickUp = ""
    dynamic var dropOff = ""
    dynamic var timePickUp = NSDate()
    dynamic var loadType = "Reefeer"
    dynamic var numberPallets = 0
    dynamic var totalPrice = 200.00
    dynamic var pricePerLoad = 2.00
}