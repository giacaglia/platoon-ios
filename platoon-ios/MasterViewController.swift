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
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        self.navigationController?.navigationBar.barTintColor = AppearanceManager.sharedInstance.cerulean
        self.navigationController?.navigationBar.tintColor = .whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor(), NSFontAttributeName:AppearanceManager.boldFont(20)]
        
        self.tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        
        self.tableView.separatorStyle = .None
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
}

extension MasterViewController {
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
}

class LoadCell : UITableViewCell {
    let nameLabel = UILabel()
    let ratingLabel = UILabel()
    let pickUpLabel = UILabel()
    let arrowImageView = UIImageView()
    let dropOffLabel = UILabel()
    
    static func cellIdentifier() -> String {
        return "LoadCell"
    }
    
    static func height() -> CGFloat {
        return 157.0
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
        self.selectionStyle = .None
      
        nameLabel.textAlignment = .Left
        nameLabel.font = AppearanceManager.mediumFont(20)
        nameLabel.textColor = AppearanceManager.sharedInstance.greyishBrown
        nameLabel.text = "Greylock Importers"
        self.contentView.addSubview(nameLabel)
        
        ratingLabel.textAlignment = .Right
        ratingLabel.font = AppearanceManager.semiboldFont(19)
        ratingLabel.textColor = AppearanceManager.sharedInstance.greyishBrown
        ratingLabel.text = "4.0"
        self.contentView.addSubview(ratingLabel)
        
        let starImageView = UIImageView()
        starImageView.image = UIImage(named: "star")
        self.contentView.addSubview(starImageView)
        
        constrain(nameLabel, ratingLabel, starImageView) { nameLabel, ratingLabel, starImageView in
            nameLabel.left  == nameLabel.superview!.left + 16
            nameLabel.top   == nameLabel.superview!.top + 17
            
            ratingLabel.right == ratingLabel.superview!.right - 34
            ratingLabel.top   == ratingLabel.superview!.top + 17
            
            starImageView.right == starImageView.superview!.right - 13
            starImageView.top   == starImageView.superview!.top + 15
        }

        pickUpLabel.textAlignment = .Left
        pickUpLabel.font = AppearanceManager.regularFont(15)
        pickUpLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        pickUpLabel.text = "Boston, MA"
        self.contentView.addSubview(pickUpLabel)
        
        arrowImageView.image = UIImage(named: "arrow")
        self.contentView.addSubview(arrowImageView)
        
        dropOffLabel.textAlignment = .Left
        dropOffLabel.font = AppearanceManager.regularFont(15)
        dropOffLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        dropOffLabel.text = "Seattle, WA"
        self.contentView.addSubview(dropOffLabel)
        
        constrain(pickUpLabel, dropOffLabel, arrowImageView) { pickUpLabel, dropOffLabel, arrowImageView in
            pickUpLabel.top    == pickUpLabel.superview!.top + 37
            pickUpLabel.left   == pickUpLabel.superview!.left + 17
            pickUpLabel.height == 22
            
            dropOffLabel.top    == dropOffLabel.superview!.top + 37
            dropOffLabel.left   == dropOffLabel.superview!.left + 148
            dropOffLabel.height == 22

            
            arrowImageView.top  == arrowImageView.superview!.top + 42
            arrowImageView.left == arrowImageView.superview!.left + 110
        }
        
        let lineView = UIView()
        lineView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.contentView.addSubview(lineView)
        constrain(lineView) { lineView in
            lineView.left    == lineView.superview!.left
            lineView.right   == lineView.superview!.right
            lineView.bottom  == lineView.superview!.bottom
            lineView.height == 1
        }
    }
    
    func setLoad(load: Load) {
        self.nameLabel.text = load.company.name
    }
    
}