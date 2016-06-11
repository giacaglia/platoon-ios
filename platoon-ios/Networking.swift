//
//  Networking.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 6/9/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class Networking {
    static let baseURL = "http://localhost:5000/api/"
    
    static func validate(phoneNumber: String) {
        let validateURL = baseURL + "validate/"
        Alamofire.request(.GET, validateURL).responseJSON { (response) in
            print(response)
        }
    }
    
    static func currentUser() -> User? {
        let realm = try! Realm()
        let users = Array(realm.objects(User.self))
        if users.count > 0 {
            return users[0]
        }
        return nil
    }
    
    
    static func fetchUsers(completionHandler:() -> Void) {
        let realm = try! Realm()
        let usersURL = baseURL + "user/"
        Alamofire.request(.GET, usersURL)
        .responseJSON { (response) in
            if let _ = response.result.error {
                return
            }
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                objects = json["objects"] as? [[String:AnyObject]] {
                for object in objects {
                    try! realm.write {
                        realm.create(User.self, value: object, update:true)
                        completionHandler()
                    }
                }
            }
        }
    }
    
    static func fetchLoads(completionHandler: () -> Void) {
        let realm = try! Realm()
        let loadsURL = baseURL + "load/"
        
        Alamofire.request(.GET, loadsURL).responseJSON { (response) in
            if let _ = response.result.error {
                return
            }
            if let json = response.result.value as? Dictionary<String, AnyObject>,
                 objects = json["objects"] as? [[String : AnyObject]] {
                for object in objects {
                    try! realm.write {
                        realm.create(Load.self, value: object, update: true)
                        completionHandler()
                    }
                }
            }
        }
    }
}