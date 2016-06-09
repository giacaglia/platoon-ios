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
    static let baseURL = "http://localhost:5000/api/"
   
    static func validate(phoneNumber: String) {
        let validateURL = baseURL + "validate/"
        Alamofire.request(.GET, validateURL).responseJSON { (response) in
            print(response)
        }
    }
    
    static func fetchLoads() {
        let loadsURL = baseURL + "load/"
        Alamofire.request(.GET, loadsURL).responseJSON { (response) in
            print("Response JSON: \(response.result.value)")
        }
    }
}