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
    
    let tableView = UITableView()
    let dateCollectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: UICollectionViewFlowLayout())
    let monthView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Trip Planning"
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        
        
        monthView.backgroundColor = .whiteColor()
        self.view.addSubview(monthView)
        
        let monthLabel = UILabel()
        monthLabel.text = "November"
        monthLabel.textAlignment = .Center
        monthLabel.font = AppearanceManager.lightFont(14)
        monthLabel.textColor = .blackColor()
        monthView.addSubview(monthLabel)
        
        let leftLine = UIView()
        leftLine.backgroundColor = UIColor(white: 151/255.0, alpha: 1.0)
        monthView.addSubview(leftLine)

        let rightLine = UIView()
        rightLine.backgroundColor = UIColor(white: 151/255.0, alpha: 1.0)
        monthView.addSubview(rightLine)
        
        constrain(monthView, monthLabel, leftLine, rightLine) { monthView, monthLabel, leftLine, rightLine in
            monthView.top    == monthView.superview!.top + 64
            monthView.left   == monthView.superview!.left
            monthView.right  == monthView.superview!.right
            monthView.height == 26
            
            monthLabel.center == monthLabel.superview!.center
            
            leftLine.left    == leftLine.superview!.left
            leftLine.right   == monthLabel.left - 16
            leftLine.centerY == leftLine.superview!.centerY
            leftLine.height  == 1
            
            rightLine.left    == monthLabel.right + 16
            rightLine.right   == monthLabel.superview!.right
            rightLine.centerY == rightLine.superview!.centerY
            rightLine.height  == 1
        }
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSize(width: DateCell.height(), height: DateCell.height())
        dateCollectionView.collectionViewLayout = layout
        dateCollectionView.registerClass(DateCell.self, forCellWithReuseIdentifier: DateCell.cellIdentifier())
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        dateCollectionView.backgroundColor = .whiteColor()
        dateCollectionView.showsVerticalScrollIndicator = false
        dateCollectionView.showsHorizontalScrollIndicator = false
        
        dateCollectionView.layer.shadowOpacity = 0.19
        dateCollectionView.layer.shadowColor = UIColor.blackColor().CGColor
        dateCollectionView.layer.shadowOffset = CGSizeMake(0, 4)
        dateCollectionView.layer.shadowRadius = 10
        dateCollectionView.layer.masksToBounds = false
        self.view.addSubview(dateCollectionView)
        constrain(dateCollectionView) { dateCollectionView in
            dateCollectionView.top    == dateCollectionView.superview!.top + 90
            dateCollectionView.left   == dateCollectionView.superview!.left
            dateCollectionView.right  == dateCollectionView.superview!.right
            dateCollectionView.height == 70
        }
        
        self.view.bringSubviewToFront(monthView)
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 160 + 21
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dateCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
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

extension TripPlanningViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DateCell.cellIdentifier(), forIndexPath: indexPath) as! DateCell
        cell.dateLabel.text = String(indexPath.row)

        if indexPath.row == 9 || indexPath.row == 2 {
            cell.setUpdated(true)
        }
        else {
            cell.setUpdated(false)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(DateCell.cellIdentifier(), forIndexPath: indexPath) as! DateCell
        cell.setSelected(true)
    }
}

class DateCell: UICollectionViewCell {
    let dateLabel = UILabel()
    let dotView   = UIView()
    
    static func cellIdentifier() -> String {
        return "DateCell"
    }
    
    static func height() -> CGFloat {
        return 36
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        dateLabel.font = AppearanceManager.extraLightFont(22)
        dateLabel.textColor = AppearanceManager.sharedInstance.greyishBrownTwo
        dateLabel.textAlignment = .Center
        dateLabel.layer.borderColor = UIColor.clearColor().CGColor
        dateLabel.layer.borderWidth = 1.0
        dateLabel.layer.cornerRadius = 18
        dateLabel.layer.masksToBounds = true
        self.contentView.addSubview(dateLabel)
        
        constrain(dateLabel) { dateLabel in
            dateLabel.center == dateLabel.superview!.center
            dateLabel.height == 36
            dateLabel.width  == 36
        }
        
        dotView.backgroundColor = AppearanceManager.sharedInstance.azure
        dotView.layer.borderColor = UIColor.clearColor().CGColor
        dotView.layer.borderWidth = 1.0
        dotView.layer.cornerRadius = 3.5
        dotView.hidden = true
        self.contentView.addSubview(dotView)
        constrain(dotView) { dotView in
            dotView.centerX == dotView.superview!.centerX
            dotView.centerY == dotView.superview!.centerY + 20
            dotView.height  == 7
            dotView.width   == 7
        }
        
    }
    
    private func setUpdated(updated: Bool) {
        if updated {
            dotView.hidden = false
        }
        else {
            dotView.hidden = true
        }
    }
    
    private func setSelected(selected: Bool) {
        dispatch_async(dispatch_get_main_queue()) { 
            if selected {
                self.dateLabel.font = AppearanceManager.regularFont(22)
                self.dateLabel.textColor = .whiteColor()
                self.dateLabel.backgroundColor = AppearanceManager.sharedInstance.azure
            }
            else {
                self.dateLabel.font = AppearanceManager.extraLightFont(22)
                self.dateLabel.textColor = AppearanceManager.sharedInstance.greyishBrownTwo
                self.dateLabel.backgroundColor = .clearColor()
            }
        }
    }
}