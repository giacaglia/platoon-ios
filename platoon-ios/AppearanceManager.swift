//
//  AppearanceManager.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import Foundation
import UIKit

class AppearanceManager {
    static let sharedInstance = AppearanceManager()
    
    let greyBlue = UIColor(red: 103.0 / 255.0, green: 122.0 / 255.0, blue: 137.0 / 255.0, alpha: 1.0)
    let cerulean = UIColor(red: 0.0, green: 141.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
    let lightGrey = UIColor(red: 196.0 / 255.0, green: 196.0 / 255.0, blue: 188.0 / 255.0, alpha: 1.0)
    let peacockBlue = UIColor(red: 0.0, green: 108.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0)
    let backgroundColor = UIColor(white: 250/255.0, alpha: 1.0)
    let gunmetal = UIColor(red: 86.0 / 255.0, green: 95.0 / 255.0, blue: 101.0 / 255.0, alpha: 1.0)
    
    
    static func mediumFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Medium", size: size)!
    }
    
    static func blackFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Black", size: size)!
    }
    
    static func boldFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Bold", size: size)!
    }
    static func lightFont(size: CGFloat) -> UIFont {
        return UIFont(name: "Graphik-Light", size: size)!
    }
}
