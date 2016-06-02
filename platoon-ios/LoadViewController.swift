//
//  LoadViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/25/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import MapKit
import Cartography

class LoadViewController : UIViewController {
    let mapView = MKMapView()
    let topMapView = MKMapView()
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    let questionTitles = ["Pickup Location", "Dropoff Location", "Pickup Time", "Weight", "Description of Pallets", "Reference #"]
    let questionAnswers = ["197 Kent St, Brookline, MA", "750 Atlantic Ave, Boston, MA", "10:50 am", "8,000 lbs", "4 pallets - 40 in x 48 in x 48 in", "1329903"]
    let imageNames = ["detailLocation", "detailLocation", "detailClock", "detailScale", "detailPallet", "detailScale"]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        self.title = "Greylock Importers"
   
        self.addRightBarButton()
        
        self.view.addSubview(mapView)
        self.addMap(mapView)
        
        constrain(mapView) { mapView in
            mapView.top    == mapView.superview!.top + 64
            mapView.left   == mapView.superview!.left
            mapView.right  == mapView.superview!.right
            mapView.height == 210
        }
        
        self.view.addSubview(topMapView)
        self.addMap(topMapView)
        
        topMapView.layer.cornerRadius = 92
        topMapView.layer.borderColor = AppearanceManager.sharedInstance.cerulean.CGColor
        topMapView.layer.borderWidth = 4
        constrain(topMapView) { topMapView in
            topMapView.top     == topMapView.superview!.top + 72
            topMapView.centerX == topMapView.superview!.centerX
            topMapView.width   == 184
            topMapView.height  == 184
        }
        
        tableView.registerClass(AnsweredCell.self, forCellReuseIdentifier: AnsweredCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.contentInset = UIEdgeInsetsMake(210, 0, 0, 0)
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(mapView, tableView) { mapView, tableView in
            tableView.top    == tableView.superview!.top + 64
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom - 84
        }
        
        let bookNowButton = UIButton()
        bookNowButton.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        self.view.addSubview(bookNowButton)
        
        let bookNowLabel = UILabel()
        bookNowLabel.text = "Book Now"
        bookNowLabel.textColor = .whiteColor()
        bookNowLabel.font = AppearanceManager.boldFont(20)
        bookNowButton.addSubview(bookNowLabel)
    
        let lineView = UIView()
        lineView.backgroundColor = .whiteColor()
        bookNowButton.addSubview(lineView)
        
        let totalPrice = UILabel()
        let myMutableString = NSMutableAttributedString(string: "$200.00", attributes: [NSFontAttributeName:AppearanceManager.semiboldFont(20)])
        myMutableString.addAttribute(NSFontAttributeName, value: AppearanceManager.lightFont(20), range: NSRange(location:0,length:1))
        totalPrice.attributedText = myMutableString
        totalPrice.textColor = .whiteColor()
        bookNowButton.addSubview(totalPrice)
        
        let priceMileLabel = UILabel()
        priceMileLabel.textColor = .whiteColor()
        let mileMutableString = NSMutableAttributedString(string: "$1.60/mile", attributes: [NSFontAttributeName:AppearanceManager.semiboldFont(14)])
        mileMutableString.addAttribute(NSFontAttributeName, value: AppearanceManager.lightFont(14), range: NSRange(location:0,length:1))
        mileMutableString.addAttribute(NSFontAttributeName, value: AppearanceManager.lightFont(14), range: NSRange(location:5,length:5))
        priceMileLabel.attributedText = mileMutableString
        bookNowButton.addSubview(priceMileLabel)
        
        constrain(bookNowButton, bookNowLabel, lineView, totalPrice, priceMileLabel) { bookNowButton, bookNowLabel, lineView, totalPrice, priceMileLabel in
            bookNowButton.bottom == bookNowButton.superview!.bottom
            bookNowButton.left   == bookNowButton.superview!.left
            bookNowButton.right  == bookNowButton.superview!.right
            bookNowButton.height == 84
            
            bookNowLabel.centerY == bookNowLabel.superview!.centerY
            bookNowLabel.left    == bookNowLabel.superview!.left + 66
            
            lineView.centerY == lineView.superview!.centerY
            lineView.left    == lineView.superview!.left + 194
            lineView.width   == 2
            lineView.height  == 25
            
            totalPrice.left == totalPrice.superview!.left + 214
            totalPrice.top  == totalPrice.superview!.top + 23
            
            priceMileLabel.left == priceMileLabel.superview!.left + 214
            priceMileLabel.top  == priceMileLabel.superview!.top + 48
        }
    }

    
    func addRightBarButton() {
        let button =  UIButton(type: .Custom)
        button.setImage(UIImage(named: "white_star"), forState: .Normal)
        button.frame = CGRectMake(0, 0, 53, 31)
        button.imageEdgeInsets = UIEdgeInsetsMake(-2, 30, 2, -30)
        let label = UILabel(frame: CGRectMake(3, 5, 50, 20))
        label.font = AppearanceManager.semiboldFont(19)
        label.text = "4.0"
        label.textAlignment = .Center
        label.textColor = UIColor.whiteColor()
        button.addSubview(label)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addBlur()
        self.view.bringSubviewToFront(topMapView)
        self.view.bringSubviewToFront(tableView)
        tableView.contentOffset = CGPointMake(0, -210)
    }
    
    private func addBlur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = mapView.frame
        blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight] // for supporting device rotation
        self.view.addSubview(blurEffectView)
    }
    
    private func addMap(mapView:MKMapView) {
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

extension LoadViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionTitles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(AnsweredCell.cellIdentifier(), forIndexPath: indexPath) as! AnsweredCell
        cell.titleLabel.text = questionTitles[indexPath.row]
        cell.subtitleLabel.text = questionAnswers[indexPath.row]
        cell.iconImageView.image = UIImage(named: imageNames[indexPath.row])
        if indexPath.row == questionTitles.count - 1 {
            cell.iconImageView.hidden = true
        }
        else {
            cell.iconImageView.hidden = false
        }
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return AnsweredCell.height()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let detailsView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 36))
        detailsView.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        
        let detailsLabel = UILabel(frame: CGRectMake(21, 7, self.view.frame.size.width - 21, 29))
        detailsLabel.textAlignment = .Left
        detailsLabel.textColor = .whiteColor()
        detailsLabel.font = AppearanceManager.semiboldFont(20)
        detailsLabel.text = "Details"
        detailsView.addSubview(detailsLabel)
        return detailsView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y <= -210 {
            scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -210)
        }
    }
}

class AnsweredCell : UITableViewCell {
    let titleLabel    = UILabel()
    let subtitleLabel = UILabel()
    let iconImageView  = UIImageView()
    
    static func cellIdentifier() -> String {
        return "AnsweredCell"
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
        self.selectionStyle = .None
       
        titleLabel.textAlignment = .Left
        titleLabel.font = AppearanceManager.semiboldFont(14)
        titleLabel.textColor = AppearanceManager.sharedInstance.cerulean
        titleLabel.text = "Pickup location"
        self.contentView.addSubview(titleLabel)
        
        subtitleLabel.textAlignment = .Left
        subtitleLabel.font = AppearanceManager.mediumFont(18)
        subtitleLabel.textColor = AppearanceManager.sharedInstance.greyishBrown
        subtitleLabel.text = "197 Kent St, Brookline, MA"
        self.contentView.addSubview(subtitleLabel)
        
        iconImageView.image = UIImage(named: "icon_cargo")
        self.contentView.addSubview(iconImageView)
        
        constrain(titleLabel, subtitleLabel, iconImageView) { titleLabel, subtitleLabel, iconImageView in
            titleLabel.left == titleLabel.superview!.left + 21
            titleLabel.top  == titleLabel.superview!.top + 15
            
            subtitleLabel.left == subtitleLabel.superview!.left + 21
            subtitleLabel.top  == subtitleLabel.superview!.top + 41
            
            iconImageView.centerY == iconImageView.superview!.centerY
            iconImageView.right   == iconImageView.superview!.right - 24
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
    
}
