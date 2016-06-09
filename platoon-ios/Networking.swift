//
//  Networking.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 6/9/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Alamofire


class Networking {
    static let baseURL = "http://127.0.0.1:5000/api/"
   
    static func validate(phoneNumber: String) {
        let validateURL = baseURL + "validate/"
        Alamofire.request(.GET, validateURL).responseJSON { (response) in
            print(response)
        }
    }
}