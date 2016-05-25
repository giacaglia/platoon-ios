//
//  BankInformationViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class BankInformationViewController : UIViewController {
    let tableView = UITableView()

    
    let questions = ["Company Name", "Federal Tax Identification Number"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.title = "Bank Information"
        self.view.addSubview(tableView)
        tableView.registerClass(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.cellIdentifier())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .None
        constrain(tableView) { tableView in
            tableView.bottom == tableView.superview!.bottom
            tableView.top    == tableView.superview!.top
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
        }
        
        self.addRightBarButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: { })
    }
    
    func addRightBarButton() {
        let rightButton = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(done))
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    func done() {
        self.presentViewController(ThankYouViewController(), animated: true) { }
    }

}


extension BankInformationViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        cell.setQuestion(questions[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NameTableViewCell.height()
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
//        cell.textField.becomeFirstResponder()
//    }
}