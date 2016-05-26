//
//  TripPlanningViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/26/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class TripPlanningViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 64
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
        
    }
}
extension TripPlanningViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LoadCell.height()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let detailsView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 36))
        detailsView.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        
        let detailsLabel = UILabel(frame: CGRectMake(21, 7, self.view.frame.size.width - 21, 29))
        detailsLabel.textAlignment = .Left
        detailsLabel.textColor = .whiteColor()
        detailsLabel.font = AppearanceManager.semiboldFont(20)
        detailsLabel.text = "November, 7th"
        detailsView.addSubview(detailsLabel)
        return detailsView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
}