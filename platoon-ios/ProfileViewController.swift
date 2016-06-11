//
//  ProfileViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class ProfileViewController : UIViewController {
    let profileImgView = UIImageView()
    let fullNameLabel  = UILabel()
    let ratingView     = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Profile"
        self.addRightButton()
        
        self.addImageCenter()
        self.addButtons()
    }
    
    private func addRightButton() {
        let button = UIButton(type: .Custom)
        button.setTitle("Edit", forState: .Normal)
        button.titleLabel!.font = AppearanceManager.semiboldFont(17)
        button.frame = CGRectMake(0, 0, 35, 30)
        button.addTarget(self, action: #selector(showProfile), forControlEvents: .TouchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }

//    private func addRightButton() {
//        let button: UIButton = UIButton(type: .Custom)
//        button.setImage(UIImage(named: "rightBack"), forState: UIControlState.Normal)
//        button.frame = CGRectMake(0, 0, 30, 31)
//        button.addTarget(self, action: #selector(back), forControlEvents: .TouchUpInside)
//        let barButton = UIBarButtonItem(customView: button)
//        self.navigationItem.rightBarButtonItem = barButton
//    }
//    
    func showProfile() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(EditProfileViewController(), animated: true)
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    private func addImageCenter() {
        let currentUser = Networking.currentUser()
        
        profileImgView.downloadedFrom(link: currentUser?.image ?? "", contentMode: .ScaleAspectFill)
        profileImgView.layer.borderColor = UIColor.whiteColor().CGColor
        profileImgView.layer.borderWidth = 5.0
        profileImgView.layer.cornerRadius = 62
        profileImgView.layer.masksToBounds = true
        profileImgView.contentMode = .ScaleAspectFill
        self.view.addSubview(profileImgView)
    
        fullNameLabel.textAlignment = .Center
        fullNameLabel.text = currentUser?.fullName()
        fullNameLabel.font = AppearanceManager.boldFont(25)
        fullNameLabel.textColor = UIColor.blackColor()
        self.view.addSubview(fullNameLabel)
        
        ratingView.layer.borderWidth = 1.0
        ratingView.layer.borderColor = UIColor.blackColor().CGColor
        ratingView.layer.cornerRadius = 11
        self.view.addSubview(ratingView)
        
        let ratingLabel = UILabel()
        ratingLabel.text = "4.0"
        ratingLabel.font = AppearanceManager.regularFont(19)
        ratingLabel.textColor = UIColor.blackColor()
        ratingView.addSubview(ratingLabel)
        
        let starImgView = UIImageView()
        starImgView.image = UIImage(named: "black_star")
        ratingView.addSubview(starImgView)
        
        ratingView.addSubview(starImgView)
        constrain(profileImgView, fullNameLabel, ratingView, ratingLabel, starImgView) { profileImgView, fullNameLabel, ratingView, ratingLabel, starImgView in
            profileImgView.centerX == profileImgView.superview!.centerX
            profileImgView.top     == profileImgView.superview!.top + 64
            profileImgView.height  == 124
            profileImgView.width   == 124
            
            fullNameLabel.centerX == fullNameLabel.superview!.centerX
            fullNameLabel.top     == profileImgView.bottom + 8
            
            ratingView.centerX == ratingView.superview!.centerX
            ratingView.top     == fullNameLabel.bottom + 9
            ratingView.width   == 84
            ratingView.height  == 36
  
            
            ratingLabel.centerY == ratingLabel.superview!.centerY
            ratingLabel.right   == ratingLabel.superview!.right - 12
            ratingLabel.height  == 20
            ratingLabel.width   == 30

            starImgView.centerY == starImgView.superview!.centerY - 2
            starImgView.left    == starImgView.superview!.left + 13
            starImgView.height  == 20
            starImgView.width   == 22
        }
    }

    private func addButtons() {
        let bankButton = UIButton()
        bankButton.backgroundColor = AppearanceManager.sharedInstance.cerulean
        bankButton.layer.borderColor = UIColor.clearColor().CGColor
        bankButton.layer.borderWidth = 1.0
        bankButton.layer.cornerRadius = 15
        bankButton.layer.masksToBounds = true
        bankButton.setTitle("Bank Information", forState: .Normal)
        bankButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        bankButton.setImage(UIImage(named: "dollar"), forState: .Normal)
        bankButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20.0, 0, 0)
        bankButton.titleLabel!.font = AppearanceManager.mediumFont(20)
        bankButton.addTarget(self, action: #selector(didPressBank), forControlEvents: .TouchUpInside)
        self.view.addSubview(bankButton)
        
        let fleetButton = UIButton()
        fleetButton.backgroundColor = AppearanceManager.sharedInstance.cerulean
        fleetButton.layer.borderColor = UIColor.clearColor().CGColor
        fleetButton.layer.borderWidth = 1.0
        fleetButton.layer.cornerRadius = 15
        fleetButton.layer.masksToBounds = true
        fleetButton.setTitle("Fleet Management", forState: .Normal)
        fleetButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        fleetButton.setImage(UIImage(named: "people"), forState: .Normal)
        fleetButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20.0, 0, 0)
        fleetButton.titleLabel!.font = AppearanceManager.mediumFont(20)
        fleetButton.addTarget(self, action: #selector(didPressFleet), forControlEvents: .TouchUpInside)
        self.view.addSubview(fleetButton)
        
        let loadButton = UIButton()
        loadButton.backgroundColor = AppearanceManager.sharedInstance.cerulean
        loadButton.layer.borderColor = UIColor.clearColor().CGColor
        loadButton.layer.borderWidth = 1.0
        loadButton.layer.cornerRadius = 15
        loadButton.layer.masksToBounds = true
        loadButton.setTitle("Load History", forState: .Normal)
        loadButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        loadButton.setImage(UIImage(named: "loadTruck"), forState: .Normal)
        loadButton.titleEdgeInsets = UIEdgeInsetsMake(0, 20.0, 0, 0)
        loadButton.titleLabel!.font = AppearanceManager.mediumFont(20)
        loadButton.addTarget(self, action: #selector(didPressLoad), forControlEvents: .TouchUpInside)
        self.view.addSubview(loadButton)
        
        constrain(bankButton, fleetButton, loadButton) { bankButton, fleetButton, loadButton in
            bankButton.top     == bankButton.superview!.top + 305
            bankButton.centerX == bankButton.superview!.centerX
            bankButton.height  == 58
            bankButton.width   == 248
          
            fleetButton.top     == bankButton.bottom + 23
            fleetButton.centerX == fleetButton.superview!.centerX
            fleetButton.height  == 58
            fleetButton.width   == 248
            
            loadButton.top     == fleetButton.bottom + 23
            loadButton.centerX == loadButton.superview!.centerX
            loadButton.height  == 58
            loadButton.width   == 248
        }
    }
    

    func didPressBank() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(BankViewController(), animated: true)
    }
    
    func didPressFleet() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(FleetViewController(), animated: true)
    }

    func didPressLoad() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title:"Back", style:.Plain, target:nil, action:nil)
        self.navigationController?.pushViewController(LoadHistoryViewController(), animated: true)
    }
}