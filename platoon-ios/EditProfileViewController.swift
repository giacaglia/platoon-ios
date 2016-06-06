//
//  EditProfileViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 6/6/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit

class EditProfileViewController : UITableViewController {
    let user = User()
    let arrayQuestions = ["First Name", "Last Name", "Phone Number", "Truck Type", "Plate Number", "Add Photo"]
    var arrayAnswers = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Edit Profile"
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.addRightButton()
        
        self.tableView.registerClass(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.cellIdentifier())
        self.tableView.separatorStyle = .None
    }
    
    private func addRightButton() {
        let doneButton = UIButton(type: .Custom)
        doneButton.setTitle("Done", forState: .Normal)
        doneButton.titleLabel!.font = AppearanceManager.semiboldFont(17)
        doneButton.addTarget(self, action: #selector(didPressDone), forControlEvents: .TouchUpInside)
        doneButton.frame = CGRectMake(0, 0, 45, 30)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: doneButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        user.first_name = "Giuliano"
        user.last_name = "Giacaglia"
        user.phone_number = "(617) 981-3206"
        user.truck_type = "Volvo"
        user.plate_number = "MARS17"
        arrayAnswers = [user.first_name, user.last_name, user.phone_number, user.truck_type, user.plate_number]
    }
    
    func didPressDone() {
               self.navigationController?.popViewControllerAnimated(true)
        self.tableView.reloadData()
    }
}


extension EditProfileViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayQuestions.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NameTableViewCell.height()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        let textField = arrayQuestions[indexPath.row]
        if textField == "Phone Number" {
            cell.cellType = .PhoneCell
        }
        else if textField == "Add Photo" {
            cell.cellType = .PhotoCell
        }
        else {
            cell.cellType = .Text
        }
        if indexPath.row >= arrayAnswers.count {
            cell.setQuestion(textField)
            return cell
        }
        
        if let text = arrayAnswers[indexPath.row] as? String {
            cell.setQuestion(textField, text: text)
        }
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.dequeueReusableCellWithIdentifier(NameTableViewCell.cellIdentifier(), forIndexPath: indexPath) as! NameTableViewCell
        if cell.cellType == .PhotoCell {
            print("Photo")
        }
        
    }
}