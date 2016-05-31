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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.Plain, target:nil, action:nil)

        self.addRightButton()
        tableView.registerClass(FleetCell.self, forCellReuseIdentifier: FleetCell.cellIdentifier())
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
    
    private func addRightButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "plus"), forState: UIControlState.Normal)
        button.frame = CGRectMake(0, 0, 30, 31)
        button.addTarget(self, action: #selector(addDriver), forControlEvents: .TouchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    func addDriver() {
        self.navigationController?.pushViewController(AddDriverViewController(), animated: true)
    }
}


extension FleetViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FleetCell.cellIdentifier(), forIndexPath: indexPath) as! FleetCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AnsweredCell.height()
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(FleetProfileViewController(), animated: true)
    }
}


class FleetCell : UITableViewCell {
    let imgView = UIImageView()
    let fullNameLabel = UILabel()
    let truckLabel = UILabel()
    let rightArrowImgView = UIImageView()
    
    static func cellIdentifier() -> String {
        return "FleetCell"
    }
    
    static func height() -> CGFloat {
        return 77.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    private func setup() {
        imgView.image = UIImage(named: "elon")
        imgView.layer.borderColor = UIColor.clearColor().CGColor
        imgView.layer.borderWidth = 1.0
        imgView.layer.cornerRadius = 22
        imgView.layer.masksToBounds = true
        imgView.contentMode = .ScaleAspectFill
        self.contentView.addSubview(imgView)
        
        fullNameLabel.text = "Esmeralda Arantes"
        fullNameLabel.textColor = AppearanceManager.sharedInstance.darkGrey
        fullNameLabel.textAlignment = .Left
        fullNameLabel.font = AppearanceManager.regularFont(20)
        self.contentView.addSubview(fullNameLabel)
        
        truckLabel.text = "Volvo - VB1467"
        truckLabel.textColor = UIColor(red: 120/255.0, green: 120/255.0, blue: 115/255.0, alpha: 1.0)
        truckLabel.textAlignment = .Left
        truckLabel.font = AppearanceManager.mediumFont(18)
        self.contentView.addSubview(truckLabel)
        
        rightArrowImgView.image = UIImage(named: "rightArrow")
        self.contentView.addSubview(rightArrowImgView)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor(white: 226/255.0, alpha: 1.0)
        self.contentView.addSubview(lineView)
        
        constrain(imgView, fullNameLabel, truckLabel, rightArrowImgView, lineView) { imgView, fullNameLabel, truckLabel, rightArrowImgView, lineView in
            imgView.centerY == imgView.superview!.centerY
            imgView.left    == imgView.superview!.left + 20
            imgView.width   == 44
            imgView.height  == 44
            
            fullNameLabel.top  == fullNameLabel.superview!.top + 15
            fullNameLabel.left == fullNameLabel.superview!.left + 82
            
            truckLabel.top  == truckLabel.superview!.top + 46
            truckLabel.left == truckLabel.superview!.left + 82
            
            rightArrowImgView.right   == rightArrowImgView.superview!.right - 9
            rightArrowImgView.centerY == rightArrowImgView.superview!.centerY
            
            lineView.bottom == lineView.superview!.bottom
            lineView.height == 1
            lineView.left   == lineView.superview!.left
            lineView.right  == lineView.superview!.right
        }
    }
}