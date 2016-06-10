//
//  MasterViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/13/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography
import RealmSwift

class MasterViewController: UITableViewController {
    var objects = [Load]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Loads"
        self.addLeftButton()
        self.addRightButton()
        self.fetchAllObjects()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.barTintColor = AppearanceManager.sharedInstance.cerulean
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:AppearanceManager.boldFont(20)]
        
        
        self.tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())        
        self.tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if !GetStartedViewController.dismissView {
            self.presentViewController(GetStartedViewController(), animated: true) { }
        }
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func showCalendar() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(TripPlanningViewController(), animated: true)
    }
    
}

extension MasterViewController {
    private func fetchAllObjects() {
        self.getLoads()
        self.getUsers()
    }
    
    private func getUsers() {
        Networking.fetchUsers { 
            print("fetched users")
        }
    }
    
    private func getLoads() {
        Networking.fetchLoads { 
            let realm = try! Realm()
            self.objects = Array(realm.objects(Load.self))
            self.tableView.reloadData()
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LoadCell.height()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell
        let load = self.objects[indexPath.row]
        cell.setLoad(load)
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(LoadViewController(), animated: true)
    }
}
