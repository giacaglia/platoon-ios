//
//  CreateAccountViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class CreateAccountViewController : UIViewController {
    let phoneTextField = PhoneTextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.title = "Create an Account"
        self.navigationController?.navigationBar.barTintColor = AppearanceManager.sharedInstance.cerulean
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:AppearanceManager.boldFont(20)]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)

        self.addTitle()
        self.addRightBarButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        phoneTextField.becomeFirstResponder()
    }
    
    func addRightBarButton() {
        let rightButton = UIBarButtonItem(title: "Next", style: .Done, target: self, action: #selector(next))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func next() {
        self.navigationController?.pushViewController(ValidationViewController(), animated: true)
    }
    
    private func addTitle() {
        let phoneLabel = UILabel()
        phoneLabel.text = "Enter your phone number:"
        phoneLabel.textAlignment = .Center
        phoneLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        phoneLabel.font = AppearanceManager.blackFont(22)
        self.view.addSubview(phoneLabel)
        
        phoneTextField.font = AppearanceManager.mediumFont(22)
        phoneTextField.attributedPlaceholder = NSAttributedString(string:"(617) 981-1234",
                                                               attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
        phoneTextField.keyboardType = .PhonePad
        self.view.addSubview(phoneTextField)
        
        constrain(phoneLabel, phoneTextField) { phoneLabel, phoneTextField in
            phoneLabel.centerX == phoneLabel.superview!.centerX
            phoneLabel.top     == phoneLabel.superview!.top + 165
            
            phoneTextField.top     == phoneLabel.bottom + 50
            phoneTextField.centerX == phoneTextField.superview!.centerX
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}