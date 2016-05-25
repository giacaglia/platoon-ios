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
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LoadCell.cellIdentifier(), forIndexPath: indexPath) as! LoadCell
        
        let object = objects[indexPath.row]
        cell.setLoad(object)
        return cell
    }
    
}

class LoadCell : UITableViewCell {
    let nameLabel = UILabel()
    
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
      
        self.contentView.addSubview(nameLabel)
        
        constrain(nameLabel) { nameLabel in
            nameLabel.left    == nameLabel.superview!.left + 21
            nameLabel.centerY == nameLabel.superview!.centerY
            nameLabel.width   == nameLabel.superview!.width - 42
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