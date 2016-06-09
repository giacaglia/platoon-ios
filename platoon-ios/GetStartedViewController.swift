//
//  GetStartedViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/24/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography
import DigitsKit

class GetStartedViewController : UIViewController {
    private let scrollView = UIScrollView()
    private let pageControl = UIPageControl()
    static var dismissView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        scrollView.pagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSizeMake(3*self.view.frame.size.width, self.view.frame.height)
        self.view.addSubview(scrollView)

        constrain(scrollView) { scrollView in
            scrollView.height == scrollView.superview!.height
            scrollView.width  == scrollView.superview!.width
        }
        
        self.view.backgroundColor = .whiteColor()
        self.addImageTextIndex(0, imageName: "load", titleText: "Find the best loads", subtitleText: "Find the most conveniant and best loads for your work")
        self.addImageTextIndex(1, imageName: "instantPricing", titleText: "Get Instant Pricing", subtitleText: "Take the loads with a instant click")
        self.addImageTextIndex(2, imageName: "manageFleet", titleText: "Manage your fleet", subtitleText: "Take the loads iwth a instant click")

        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = UIColor(white: 217/255.0, alpha: 1.0)
        pageControl.currentPageIndicatorTintColor = UIColor(white: 51/255.0, alpha: 1.0)
        self.view.addSubview(pageControl)
        constrain(pageControl) { pageControl in
            pageControl.bottom == pageControl.superview!.bottom - 112
            pageControl.centerX == pageControl.superview!.centerX
        }
        
        self.addGetStartedButton()
    }
    
    private func addGetStartedButton() {
        
        let getStartedButton = DGTAuthenticateButton(authenticationCompletion: { (session: DGTSession?, error: NSError?) in
            if (session != nil) {
                GetStartedViewController.dismissView = true
                self.presentingViewController?.dismissViewControllerAnimated(true, completion: { })
            } else {
                NSLog("Authentication error: %@", error!.localizedDescription)
            }
        })
        
        getStartedButton.backgroundColor = .clearColor()
        getStartedButton.setTitle("Get Started", forState: .Normal)
        getStartedButton.setTitleColor(AppearanceManager.sharedInstance.cerulean, forState: .Normal)
        getStartedButton.titleLabel?.font = AppearanceManager.blackFont(20)
        getStartedButton.addTarget(self, action: #selector(didPressGetStarted), forControlEvents: .TouchUpInside)
        getStartedButton.setImage(UIImage(named: "arrow_forward"), forState: .Normal)
        getStartedButton.imageEdgeInsets = UIEdgeInsetsMake(0, 135, 0, -135)
        self.view.addSubview(getStartedButton)
        
        
        let digitsAppearance = DGTAppearance()
        digitsAppearance.backgroundColor = .whiteColor()
        digitsAppearance.accentColor = AppearanceManager.sharedInstance.cerulean
        digitsAppearance.headerFont = AppearanceManager.semiboldFont(18)
        digitsAppearance.labelFont = AppearanceManager.semiboldFont(16)
        digitsAppearance.bodyFont = AppearanceManager.regularFont(18)
        getStartedButton.digitsAppearance = digitsAppearance
        
        constrain(getStartedButton) { getStartedButton in
            getStartedButton.bottom  == getStartedButton.superview!.bottom - 20
            getStartedButton.centerX == getStartedButton.superview!.centerX
        }

    }
    

    private func addImageTextIndex(pageIndex: Int, imageName: String, titleText: String, subtitleText: String) {
        let truckImageView = UIImageView()
        truckImageView.image = UIImage(named: imageName)
        truckImageView.contentMode = .ScaleAspectFill
        scrollView.addSubview(truckImageView)
        
        let sumUp = pageIndex * Int(self.view.frame.size.width)
        constrain(truckImageView) { truckImageView in
            truckImageView.top     == truckImageView.superview!.top + 208
            truckImageView.height  == 72
            truckImageView.width   == 198
            truckImageView.centerX == truckImageView.superview!.centerX  + CGFloat(sumUp)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = titleText
        titleLabel.font = AppearanceManager.blackFont(24)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        scrollView.addSubview(titleLabel)
        
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitleText
        subtitleLabel.font = AppearanceManager.lightFont(19)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.textAlignment = .Center
        subtitleLabel.textColor = AppearanceManager.sharedInstance.greyBlue
        scrollView.addSubview(subtitleLabel)
        
        constrain(titleLabel, subtitleLabel) { titleLabel, subtitleLabel in
            titleLabel.top        == titleLabel.superview!.top + 380
            titleLabel.centerX    == titleLabel.superview!.centerX + CGFloat(sumUp)
            
            subtitleLabel.top     == titleLabel.bottom + 14
            subtitleLabel.width   == 260
            subtitleLabel.centerX == subtitleLabel.superview!.centerX + CGFloat(sumUp)
        }
        
    }

    
    func didPressGetStarted() {
        let navController = UINavigationController(rootViewController: CreateAccountViewController())
        self.presentViewController(navController, animated: true) {}
    }
}


extension GetStartedViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/self.view.frame.size.width
        pageControl.currentPage = Int(page)
    }
}
