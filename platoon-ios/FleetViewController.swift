//
//  FleetViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class FleetViewController : UIViewController {
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Fleet Management"
        
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
}


extension FleetViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AnsweredCell.cellIdentifier(), forIndexPath: indexPath) as! AnsweredCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AnsweredCell.height()
    }
}