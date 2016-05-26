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
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        self.title = "Greylock Importers"
        
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
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 210
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.addBlur()
        self.view.bringSubviewToFront(topMapView)
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
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
}

class AnsweredCell : UITableViewCell {
    let titleLabel = UITextField()
    
    static func cellIdentifier() -> String {
        return "AnsweredCell"
    }
    
    static func height() -> CGFloat {
        return 78.0
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
        self.contentView.addSubview(titleLabel)
        
        constrain(titleLabel) { titleLabel in
            titleLabel.left == titleLabel.superview!.left + 21
            titleLabel.top  == titleLabel.superview!.top + 15
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
