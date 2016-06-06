//
//  ThankYouViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography

class ThankYouViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
        self.addTitle()
    }
    
    
    private func addTitle() {
        let thankYouLabel = UILabel()
        thankYouLabel.text = "Thank you for\n your interest!"
        thankYouLabel.textAlignment = .Center
        thankYouLabel.numberOfLines = 2
        thankYouLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        thankYouLabel.font = AppearanceManager.blackFont(24)
        self.view.addSubview(thankYouLabel)
        
        
        let ticketImageView = UIImageView()
        ticketImageView.image = UIImage(named: "ticket")
        ticketImageView.contentMode = .ScaleAspectFill
        self.view.addSubview(ticketImageView)
        
        let numberTruckersLabel = UILabel()
        numberTruckersLabel.text = "110,100 truckers\nahead of you"
        numberTruckersLabel.textAlignment = .Center
        numberTruckersLabel.numberOfLines = 2
        numberTruckersLabel.textColor = .whiteColor()
        numberTruckersLabel.font = AppearanceManager.blackFont(24)
        ticketImageView.addSubview(numberTruckersLabel)
        
        constrain(thankYouLabel, ticketImageView, numberTruckersLabel) { thankYouLabel, ticketImageView, numberTruckersLabel in
            thankYouLabel.top     == thankYouLabel.superview!.top + 102
            thankYouLabel.centerX == thankYouLabel.superview!.centerX
            
            ticketImageView.top     == ticketImageView.superview!.top + 188
            ticketImageView.centerX == ticketImageView.superview!.centerX
            ticketImageView.width   == 306
            ticketImageView.height  == 140
            
            numberTruckersLabel.center == numberTruckersLabel.superview!.center
        }
        
        
        let interestedInLabel = UILabel()
        interestedInLabel.text = "Interested in\npriority access?"
        interestedInLabel.textAlignment = .Center
        interestedInLabel.numberOfLines = 2
        interestedInLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        interestedInLabel.font = AppearanceManager.blackFont(24)
        self.view.addSubview(interestedInLabel)
        
        let getPriorityLabel = UILabel()
        getPriorityLabel.text = "Get priority access by refeerring other truckers. The more people join, the sooner you’ll get access."
        getPriorityLabel.font = UIFont(name: "Helvetica", size: 18)
        getPriorityLabel.numberOfLines = 0
        getPriorityLabel.textAlignment = .Center
        getPriorityLabel.textColor = AppearanceManager.sharedInstance.gunmetal
        self.view.addSubview(getPriorityLabel)
        
        constrain(interestedInLabel, getPriorityLabel) { interestedInLabel, getPriorityLabel in
            interestedInLabel.top     == interestedInLabel.superview!.top + 402
            interestedInLabel.centerX == interestedInLabel.superview!.centerX
            
            getPriorityLabel.top   == getPriorityLabel.superview!.top + 482
            getPriorityLabel.left  == getPriorityLabel.superview!.left + 54
            getPriorityLabel.right == getPriorityLabel.superview!.right - 54
        }
        
        let shareNowButton = UIButton()
        shareNowButton.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        shareNowButton.titleLabel!.font = AppearanceManager.boldFont(20)
        shareNowButton.setTitle("Share now", forState: .Normal)
        shareNowButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        shareNowButton.addTarget(self, action: #selector(didPressShare), forControlEvents: .TouchUpInside)
        self.view.addSubview(shareNowButton)
        
        constrain(shareNowButton) { shareNowButton in
            shareNowButton.bottom == shareNowButton.superview!.bottom
            shareNowButton.height == 84
            shareNowButton.left   == shareNowButton.superview!.left
            shareNowButton.right  == shareNowButton.superview!.right
        }
    }
    
    func didPressShare() {
        
//        self.presentingViewController?.dismissViewControllerAnimated(true, completion: {
//        })
//        let textToShare = "Swift is awesome!  Check out this website about it!"
//        
//        if let myWebsite = NSURL(string: "http://www.codingexplorer.com/") {
//            let objectsToShare = [textToShare, myWebsite]
//            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
//            self.presentViewController(activityVC, animated: true, completion: nil)
//        }
    }
}
