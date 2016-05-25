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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
        self.title = "Create an Account"
        self.addRightBarButton()
        
        self.view.addSubview(tableView)
        tableView.registerClass(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        tableView.separatorStyle = .None
        tableView.tableFooterView = UIView()
        constrain(tableView) { tableView in
            tableView.bottom == tableView.superview!.bottom
            tableView.top    == tableView.superview!.top
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
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.tableView.frame.origin.y -= keyboardSize.height
//        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
//            self.view.frame.origin.y += keyboardSize.height
//        }
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
        return 77.0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        cell.textField.becomeFirstResponder()
    }
}



class NameTableViewCell : UITableViewCell {
    let textField = UITextField()
    
    static func cellIdentifier() -> String {
        return "NameTableViewCell"
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
        self.contentView.addSubview(textField)
        
        constrain(textField) { textField in
            textField.left    == textField.superview!.left + 21
            textField.centerY == textField.superview!.centerY
            textField.width   == textField.superview!.width - 42
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
        
    }
    
    func setQuestion(placeholderText: String) {
        textField.attributedPlaceholder = NSAttributedString(string:placeholderText,
                                                                  attributes:[NSForegroundColorAttributeName: AppearanceManager.sharedInstance.lightGrey])
    }
}