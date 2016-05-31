//
//  LoadHistoryViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class LoadHistoryViewController : UIViewController {
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Load History"

        self.addMonthSelecter()
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 240
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    private func addMonthSelecter() {
        let monthView = UIView()
        monthView.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        self.view.addSubview(monthView)
        
        let monthLabel = UILabel()
        monthLabel.text = "June"
        monthLabel.textAlignment = .Center
        monthLabel.font = AppearanceManager.semiboldFont(20)
        monthLabel.textColor = .whiteColor()
        monthView.addSubview(monthLabel)
        
        let leftArrow = UIButton()
        leftArrow.setImage(UIImage(named: "leftArrow"), forState: .Normal)
        leftArrow.addTarget(self, action: #selector(moveLeft), forControlEvents: .TouchUpInside)
        monthView.addSubview(leftArrow)
        
        let rightArrow = UIButton()
        rightArrow.setImage(UIImage(named: "whiteRightArrow"), forState: .Normal)
        rightArrow.addTarget(self, action: #selector(moveRight), forControlEvents: .TouchUpInside)
        monthView.addSubview(rightArrow)
        
        constrain(monthView, monthLabel, leftArrow, rightArrow) { monthView, monthLabel, leftArrow, rightArrow in
            monthView.top    == monthView.superview!.top + 64
            monthView.left   == monthView.superview!.left
            monthView.right  == monthView.superview!.right
            monthView.height == 57
            
            monthLabel.center == monthLabel.superview!.center
            
            leftArrow.left    == leftArrow.superview!.left + 10
            leftArrow.centerY == leftArrow.superview!.centerY
            
            rightArrow.right   == rightArrow.superview!.right - 10
            rightArrow.centerY == rightArrow.superview!.centerY
        }
    }
    
    func moveLeft() {
        
    }
    
    func moveRight() {
        
    }
}

extension LoadHistoryViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LoadCell.height()
    }
    
}