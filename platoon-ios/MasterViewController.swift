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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)

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

class LoadCell : UITableViewCell {
    let nameLabel         = UILabel()
    let ratingLabel       = UILabel()
    let pickUpLabel       = UILabel()
    let arrowImageView    = UIImageView()
    let dropOffLabel      = UILabel()
    let clockImageView    = UIImageView()
    let timeLabel         = UILabel()
    let locationImageView = UIImageView()
    let distanceLabel     = UILabel()
    let cargoImageView    = UIImageView()
    let truckLabel        = UILabel()
    let palletImageView   = UIImageView()
    let numberPalletLabel = UILabel()
    let totalPriceLabel   = UILabel()
    let priceMileLabel    = UILabel()
    
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
        
        
        clockImageView.image = UIImage(named: "clock")
        self.contentView.addSubview(clockImageView)
        
        timeLabel.textAlignment = .Left
        timeLabel.font = AppearanceManager.regularFont(14)
        timeLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        timeLabel.text = "10:50 am"
        self.contentView.addSubview(timeLabel)
        
        locationImageView.image = UIImage(named: "location")
        self.contentView.addSubview(locationImageView)
        
        distanceLabel.textAlignment = .Left
        distanceLabel.font = AppearanceManager.regularFont(14)
        distanceLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        distanceLabel.text = "4 miles"
        self.contentView.addSubview(distanceLabel)
        
        constrain(clockImageView, timeLabel, locationImageView, distanceLabel) { clockImageView, timeLabel, locationImageView, distanceLabel in
            clockImageView.left   == clockImageView.superview!.left + 16
            clockImageView.top    == clockImageView.superview!.top + 76
            clockImageView.width  == 25
            clockImageView.height == 24
            
            timeLabel.left   == timeLabel.superview!.left + 53
            timeLabel.bottom == clockImageView.bottom
            timeLabel.height == 22
            
            locationImageView.left    == locationImageView.superview!.left + 140
            locationImageView.bottom  == clockImageView.bottom
            locationImageView.height  == 28
            
            distanceLabel.left   == distanceLabel.superview!.left + 172
            distanceLabel.bottom == locationImageView.bottom
            distanceLabel.height == 22
        }
        
        cargoImageView.image = UIImage(named:"cargo")
        self.contentView.addSubview(cargoImageView)
        
        truckLabel.textAlignment = .Left
        truckLabel.font = AppearanceManager.regularFont(14)
        truckLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        truckLabel.text = "Reefeer"
        self.contentView.addSubview(truckLabel)
        
        palletImageView.image = UIImage(named:"pallet")
        self.contentView.addSubview(palletImageView)
        
        numberPalletLabel.textAlignment = .Left
        numberPalletLabel.font = AppearanceManager.regularFont(14)
        numberPalletLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        numberPalletLabel.text = "3 pallets"
        self.contentView.addSubview(numberPalletLabel)
        
        constrain(cargoImageView, truckLabel, palletImageView, numberPalletLabel) { cargoImageView, truckLabel, palletImageView, numberPalletLabel in
            cargoImageView.left   == cargoImageView.superview!.left + 12
            cargoImageView.top    == cargoImageView.superview!.top + 110
            cargoImageView.width  == 32
            cargoImageView.height == 26
            
            truckLabel.left   == truckLabel.superview!.left + 53
            truckLabel.bottom == cargoImageView.bottom
            truckLabel.height == 22
            
            palletImageView.left   == palletImageView.superview!.left + 131
            palletImageView.bottom == cargoImageView.bottom
            palletImageView.height == 32
            
            numberPalletLabel.left   == numberPalletLabel.superview!.left + 172
            numberPalletLabel.bottom == cargoImageView.bottom
            numberPalletLabel.height == 22
        }
        
        
        totalPriceLabel.textAlignment = .Right
        totalPriceLabel.font = AppearanceManager.semiboldFont(20)
        totalPriceLabel.textColor = AppearanceManager.sharedInstance.battleshipGrey
        totalPriceLabel.text = "$200.00"
        self.contentView.addSubview(totalPriceLabel)
        
        priceMileLabel.textAlignment = .Right
        priceMileLabel.font = AppearanceManager.regularFont(14)
        priceMileLabel.textColor = AppearanceManager.sharedInstance.battleshipGrey
        priceMileLabel.text = "$1.60/mile"
        self.contentView.addSubview(priceMileLabel)
        
        constrain(totalPriceLabel, priceMileLabel) { totalPriceLabel, priceMileLabel in
            totalPriceLabel.right  == totalPriceLabel.superview!.right - 15
            totalPriceLabel.top    == totalPriceLabel.superview!.top + 98
            totalPriceLabel.height == 20
            
            priceMileLabel.right  == priceMileLabel.superview!.right - 15
            priceMileLabel.top    == priceMileLabel.superview!.top + 123
            priceMileLabel.height == 15
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
        self.ratingLabel.text = String(load.company.rating)
        self.pickUpLabel.text = load.pickUp
        self.dropOffLabel.text = load.dropOff
    }
    
}