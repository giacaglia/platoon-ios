//
//  BankViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class BankViewController : UIViewController {
    let tableView = UITableView()
    
    let titleQuestions = ["Business Name", "Federal Tax Indentification Number"]
    let subtitleQuestions = ["Trucking Moving Inc.", "1237478123"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Bank Information"
        
        self.addRightButton()
        tableView.registerClass(AnsweredCell.self, forCellReuseIdentifier: AnsweredCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) {tableView in
            tableView.top    == tableView.superview!.top
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    private func addRightButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setTitle("Edit", forState: .Normal)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.frame = CGRectMake(0, 0, 35, 31)
        button.addTarget(self, action: #selector(editBankInfo), forControlEvents: .TouchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }

    func editBankInfo() {
        
    }
}


extension BankViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AnsweredCell.cellIdentifier(), forIndexPath: indexPath) as! AnsweredCell
        
        cell.titleLabel.text = titleQuestions[indexPath.row]
        cell.subtitleLabel.text = subtitleQuestions[indexPath.row]
        cell.iconImageView.hidden = true
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AnsweredCell.height()
    }

}