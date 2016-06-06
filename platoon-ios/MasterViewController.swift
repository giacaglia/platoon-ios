//
//  MasterViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/13/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class MasterViewController: UITableViewController {
    var objects = [Load]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Loads"
        self.addLeftButton()
        self.addRightButton()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.barTintColor = AppearanceManager.sharedInstance.cerulean
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:AppearanceManager.boldFont(20)]
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        
        self.tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())        
        self.tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidLayoutSubviews()
        self.presentViewController(GetStartedViewController(), animated: true, completion: nil)
    }
    
    private func addLeftButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "profile"), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 0, 25, 31)
        button.addTarget(self, action: #selector(showProfile), forControlEvents: .TouchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    private func addRightButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "calendar"), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 0, 30, 31)
        button.addTarget(self, action: #selector(showCalendar), forControlEvents: .TouchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func showProfile() {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func showCalendar() {
        self.navigationController?.pushViewController(TripPlanningViewController(), animated: true)
    }
    
}

extension MasterViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LoadCell.height()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell

//        let object = objects[indexPath.row]
//        cell.setLoad(object)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(LoadViewController(), animated: true)
    }
}
