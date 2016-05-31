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
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
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
        self.view.addSubview(dateCollectionView)
        constrain(dateCollectionView) { dateCollectionView in
            dateCollectionView.top    == dateCollectionView.superview!.top + 64
            dateCollectionView.left   == dateCollectionView.superview!.left
            dateCollectionView.right  == dateCollectionView.superview!.right
            dateCollectionView.height == 70
        }
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 134
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
        if indexPath.row == 8 {
            cell.setSelected(true)
        }
        else {
            cell.setSelected(false)
        }
        return cell
    }
}

class DateCell: UICollectionViewCell {
    let dateLabel = UILabel()
    
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
        
    }
    
    private func setSelected(selected: Bool) {
        if selected {
            dateLabel.font = AppearanceManager.regularFont(22)
            dateLabel.textColor = .whiteColor()
            dateLabel.backgroundColor = AppearanceManager.sharedInstance.azure
        }
        else {
            dateLabel.font = AppearanceManager.extraLightFont(22)
            dateLabel.textColor = AppearanceManager.sharedInstance.greyishBrownTwo
            dateLabel.backgroundColor = .clearColor()
        }
    }
}