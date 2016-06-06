//
//  DetailsViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class DetailsViewController : UIViewController {
    struct Question {
        var placeholderText = ""
    }
    
    let arrayQuestions = ["First Name", "Last Name", "Company Name", "MC or USDOT #", "City", "State", "Zip Code"]
    let tableView = UITableView()
    
    var tableViewConstrain : ConstraintGroup = ConstraintGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        
        self.title = "Create an Account"
        self.addRightBarButton()
        
        self.view.addSubview(tableView)
        tableView.registerClass(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        constrain(tableView, replace: tableViewConstrain) { tableView in
            tableView.top    == tableView.superview!.top
            tableView.height == tableView.superview!.height
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
        }
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func addRightBarButton() {
        let rightButton = UIBarButtonItem(title: "Next", style: .Done, target: self, action: #selector(next))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func next() {
        self.navigationController?.pushViewController(BankInformationViewController(), animated: true)
    }

    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            constrain(tableView, replace: tableViewConstrain) { tableView in
                tableView.top    == tableView.superview!.top
                tableView.height == tableView.superview!.height - keyboardSize.size.height
                tableView.left   == tableView.superview!.left
                tableView.right  == tableView.superview!.right
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        constrain(tableView, replace: tableViewConstrain) { tableView in
            tableView.top    == tableView.superview!.top
            tableView.height == tableView.superview!.height
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
        }
        self.view.layoutIfNeeded()
    }
}

extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayQuestions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        cell.setQuestion(arrayQuestions[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NameTableViewCell.height()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        cell.textField.becomeFirstResponder()
    }
}



class NameTableViewCell : UITableViewCell {
    enum CellType { case Text, LastCellText, PhoneCell, PhotoCell }
    
    let textField      = UITextField()
    let phoneTextField = PhoneTextField()
    let plusImageView  = UIImageView()
    let addPhotoLabel = UILabel()
    var cellType : CellType = .Text {
        didSet {
            switch cellType {
            case .Text:
                self.textField.hidden        = false
                self.phoneTextField.hidden   = true
                self.textField.returnKeyType = .Next
                self.plusImageView.hidden    = true
                self.addPhotoLabel.hidden   = true
            case .LastCellText:
                self.textField.hidden        = false
                self.phoneTextField.hidden   = true
                self.textField.returnKeyType = .Done
                self.plusImageView.hidden    = true
                self.addPhotoLabel.hidden   = true
            case .PhoneCell:
                self.textField.hidden        = true
                self.phoneTextField.hidden   = false
                self.plusImageView.hidden    = true
                self.addPhotoLabel.hidden   = true
            case .PhotoCell:
                self.textField.hidden        = true
                self.phoneTextField.hidden   = true
                self.plusImageView.hidden    = false
                self.addPhotoLabel.hidden   = false
            }
        }
    }
    
    static func cellIdentifier() -> String {
        return "NameTableViewCell"
    }
    
    static func height() -> CGFloat {
        return 77.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    private func setup() {
        self.selectionStyle = .None
        textField.autocorrectionType = .No
        textField.font = AppearanceManager.mediumFont(18)
        self.contentView.addSubview(textField)
        
        constrain(textField) { textField in
            textField.left    == textField.superview!.left + 21
            textField.centerY == textField.superview!.centerY
            textField.width   == textField.superview!.width - 42
        }
        
        phoneTextField.autocorrectionType = .No
        phoneTextField.font = AppearanceManager.mediumFont(18)
        phoneTextField.hidden = true
        self.contentView.addSubview(phoneTextField)
        constrain(phoneTextField) { phoneTextField in
            phoneTextField.left    == phoneTextField.superview!.left + 21
            phoneTextField.centerY == phoneTextField.superview!.centerY
            phoneTextField.width   == phoneTextField.superview!.width - 42
        }
        
        let lineView = UIView()
        lineView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.contentView.addSubview(lineView)
        constrain(lineView) { lineView in
            lineView.left    == lineView.superview!.left
            lineView.right   == lineView.superview!.right
            lineView.bottom  == lineView.superview!.bottom
            lineView.height == 1
        }
        
        plusImageView.image = UIImage(named: "add")
        plusImageView.contentMode = .ScaleAspectFill
        plusImageView.hidden = true
        self.contentView.addSubview(plusImageView)
        
        addPhotoLabel.text = "Add Photo"
        addPhotoLabel.font = AppearanceManager.mediumFont(18)
        addPhotoLabel.textAlignment = .Left
        addPhotoLabel.textColor = AppearanceManager.sharedInstance.mediumGrey
        addPhotoLabel.hidden = true
        self.contentView.addSubview(addPhotoLabel)
        
        constrain(plusImageView, addPhotoLabel) { plusImageView, addDriverLabel in
            plusImageView.left    == plusImageView.superview!.left + 20
            plusImageView.centerY == plusImageView.superview!.centerY
            
            addDriverLabel.left    == addDriverLabel.superview!.left + 80
            addDriverLabel.centerY == addDriverLabel.superview!.centerY
        }

    }
    
    func setQuestion(placeholderText: String) {
        textField.attributedPlaceholder = NSAttributedString(string:placeholderText,
                                                                  attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
        phoneTextField.attributedPlaceholder = NSAttributedString(string:placeholderText,
                                                                  attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
    }
}