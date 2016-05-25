//
//  ValidationViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class ValidationViewController : UIViewController {
    let validationTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.title = "Create an Account"

        self.addTitle()
        self.addRightBarButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        validationTextField.becomeFirstResponder()
    }
    
    func addRightBarButton() {
        let rightButton = UIBarButtonItem(title: "Next", style: .Done, target: self, action: #selector(next))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func next() {
        self.navigationController?.pushViewController(DetailsViewController(), animated: true)
    }
    
    func addTitle() {
        let validationLabel = UILabel()
        validationLabel.text = "Enter the validation\ncode"
        validationLabel.numberOfLines = 2
        validationLabel.textAlignment = .Center
        validationLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        validationLabel.font = UIFont.boldSystemFontOfSize(23)
        self.view.addSubview(validationLabel)
        
        
        validationTextField.font = UIFont(name: "Graphik-Medium", size: 22)
        validationTextField.attributedPlaceholder = NSAttributedString(string:"234-402",
                                                                  attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
        validationTextField.keyboardType = .NumberPad
        self.view.addSubview(validationTextField)
        
        constrain(validationLabel, validationTextField) { validationLabel, validationTextField in
            validationLabel.top     == validationLabel.superview!.top + 153
            validationLabel.centerX == validationLabel.superview!.centerX
            
            validationTextField.top     == validationTextField.superview!.top + 240
            validationTextField.centerX == validationTextField.superview!.centerX
        }
    }
}