//
//  AddDriverViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography
class AddDriverViewController : UITableViewController {
    let arrayQuestions = ["First Name", "Last Name", "Phone Number", "Truck Type", "Plate Number"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Driver"
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.addRightButton()

        self.tableView.registerClass(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.cellIdentifier())
        self.tableView.separatorStyle = .None
    }
    
    private func addRightButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setTitle("Done", forState: .Normal)
        button.frame = CGRectMake(0, 0, 45, 31)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
}


extension AddDriverViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayQuestions.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NameTableViewCell.height()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        cell.setQuestion(arrayQuestions[indexPath.row])
        return cell
    }
}
