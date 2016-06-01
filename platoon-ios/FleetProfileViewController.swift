//
//  FleetProfileViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography
import MapKit

class FleetProfileViewController : UIViewController {
    let mapView = MKMapView()
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Elon Musk"
        self.addRightButton()
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(initialLocation.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        self.view.addSubview(mapView)
        constrain(mapView) { mapView in
            mapView.top    == mapView.superview!.top
            mapView.left   == mapView.superview!.left
            mapView.right  == mapView.superview!.right
            mapView.height == 240
        }
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(mapView, tableView) { mapView, tableView in
            tableView.top    == tableView.superview!.top + 240
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPointMake(0, 0)
    }
    private func addRightButton() {
        let button: UIButton = UIButton(type: .Custom)
        button.setImage(UIImage(named: "elon"), forState: UIControlState.Normal)
        button.imageView?.contentMode = .ScaleAspectFit
        button.imageView?.layer.borderColor = UIColor.whiteColor().CGColor
        button.imageView?.layer.borderWidth = 2.0
        button.imageView?.layer.cornerRadius = 17
        button.frame = CGRectMake(0, 0, 35, 35)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
}


extension FleetProfileViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return LoadCell.height()
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let loadView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width, 36))
        loadView.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        
        let loadLabel = UILabel(frame: CGRectMake(21, 7, self.view.frame.size.width - 21, 29))
        loadLabel.textAlignment = .Left
        loadLabel.textColor = .whiteColor()
        loadLabel.font = AppearanceManager.semiboldFont(20)
        loadLabel.text = "Load History"
        loadView.addSubview(loadLabel)
        return loadView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }

}