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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
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
        validationLabel.text = "Enter the validation\ncode:"
        validationLabel.numberOfLines = 2
        validationLabel.textAlignment = .Center
        validationLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        validationLabel.font = AppearanceManager.blackFont(22)
        self.view.addSubview(validationLabel)
        
        
        validationTextField.font = AppearanceManager.mediumFont(22)
        validationTextField.attributedPlaceholder = NSAttributedString(string:"234-402",
                                                                  attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
        validationTextField.delegate = self
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

extension ValidationViewController : UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text! as NSString).stringByReplacingCharactersInRange(range, withString: string)
        let components = newString.componentsSeparatedByCharactersInSet(NSCharacterSet.decimalDigitCharacterSet().invertedSet)
        
        let decimalString = components.joinWithSeparator("") as NSString
        let length = decimalString.length
        
        if length == 0 || length > 6
        {
            let newLength = (textField.text! as NSString).length + (string as NSString).length - range.length as Int
            
            return (newLength > 6) ? false : true
        }
        var index = 0 as Int
        let formattedString = NSMutableString()
        
        if length - index > 3
        {
            let prefix = decimalString.substringWithRange(NSMakeRange(index, 3))
            formattedString.appendFormat("%@-", prefix)
            index += 3
        }
        
        let remainder = decimalString.substringFromIndex(index)
        formattedString.appendString(remainder)
        textField.text = formattedString as String
        return false
    }
}