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
        self.addSummary()
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 64 + 240
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        tableView.contentOffset = CGPointMake(0, 0)
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
    
    func addSummary() {
        let loadLabel = UILabel()
        loadLabel.text = "Load Summary"
        loadLabel.textAlignment = .Left
        loadLabel.font = AppearanceManager.semiboldFont(20)
        loadLabel.textColor = AppearanceManager.sharedInstance.cerulean
        self.view.addSubview(loadLabel)
        
        let totalGrossLabel = UILabel()
        totalGrossLabel.text = "$35,000.00"
        totalGrossLabel.textAlignment = .Left
        totalGrossLabel.font = AppearanceManager.mediumFont(16)
        totalGrossLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(totalGrossLabel)
        
        let grossSalesLabel = UILabel()
        grossSalesLabel.text = "Gross Sales"
        grossSalesLabel.textAlignment = .Left
        grossSalesLabel.font = AppearanceManager.mediumFont(18)
        grossSalesLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(grossSalesLabel)
        
        constrain(loadLabel, totalGrossLabel, grossSalesLabel) { loadLabel, totalGrossLabel, grossSalesLabel in
            loadLabel.left == loadLabel.superview!.left + 8
            loadLabel.top  == loadLabel.superview!.top + 132
            
            totalGrossLabel.left == totalGrossLabel.superview!.left + 8
            totalGrossLabel.top  == loadLabel.bottom + 10
            
            grossSalesLabel.left == grossSalesLabel.superview!.left + 8
            grossSalesLabel.top  == loadLabel.bottom + 34
        }
        
        let totalLoadsLabel = UILabel()
        totalLoadsLabel.text = "40"
        totalLoadsLabel.textAlignment = .Left
        totalLoadsLabel.font = AppearanceManager.mediumFont(16)
        totalLoadsLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(totalLoadsLabel)
        
        let loads = UILabel()
        loads.text = "Loads"
        loads.textAlignment = .Left
        loads.font = AppearanceManager.mediumFont(18)
        loads.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(loads)

        constrain(loadLabel, totalLoadsLabel, loads) { loadLabel, totalLoadsLabel, loads in
            totalLoadsLabel.left == totalLoadsLabel.superview!.left + 168
            totalLoadsLabel.top  == loadLabel.bottom + 10
            
            loads.left == loads.superview!.left + 168
            loads.top  == loadLabel.bottom + 34
        }
        
        let priceLabel = UILabel()
        priceLabel.text = "$500.00"
        priceLabel.textAlignment = .Left
        priceLabel.font = AppearanceManager.mediumFont(16)
        priceLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(priceLabel)
        
        let averageLoadLabel = UILabel()
        averageLoadLabel.text = "Average Load"
        averageLoadLabel.textAlignment = .Left
        averageLoadLabel.font = AppearanceManager.mediumFont(18)
        averageLoadLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(averageLoadLabel)
        
        constrain(loadLabel, priceLabel, averageLoadLabel) { loadLabel, priceLabel, averageLoadLabel in
            priceLabel.left == priceLabel.superview!.left + 248
            priceLabel.top  == loadLabel.bottom + 10
            
            averageLoadLabel.left == averageLoadLabel.superview!.left + 248
            averageLoadLabel.top == loadLabel.bottom + 34
        }
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