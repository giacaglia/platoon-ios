//
//  LoadHistoryViewController.swift
//  platoon-ios
//
//  Created by Giuliano Giacaglia on 5/31/16.
//  Copyright © 2016 Platoon. All rights reserved.
//

import UIKit
import Cartography
import Charts

class LoadHistoryViewController : UIViewController {
    let tableView = UITableView(frame: CGRectZero, style: .Grouped)
    var barChartView = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        self.title = "Load History"
        
        self.addMonthSelecter()
        self.addSummary()
        self.addSummaryLineChart()
        
        tableView.registerClass(LoadCell.self, forCellReuseIdentifier: LoadCell.cellIdentifier())
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clearColor()
        tableView.showsVerticalScrollIndicator = false
        self.view.addSubview(tableView)
        constrain(tableView) { tableView in
            tableView.top    == tableView.superview!.top + 64 + 270
            tableView.left   == tableView.superview!.left
            tableView.right  == tableView.superview!.right
            tableView.bottom == tableView.superview!.bottom
        }
    }
    
    private func addMonthSelecter() {
        let monthView = UIView()
        monthView.backgroundColor = AppearanceManager.sharedInstance.peacockBlue
        self.view.addSubview(monthView)
        
        let monthLabel = UILabel()
        monthLabel.text = "June"
        monthLabel.textAlignment = .Center
        monthLabel.font = AppearanceManager.semiboldFont(20)
        monthLabel.textColor = .whiteColor()
        monthView.addSubview(monthLabel)
        
        let leftArrow = UIButton()
        leftArrow.setImage(UIImage(named: "leftArrow"), forState: .Normal)
        leftArrow.addTarget(self, action: #selector(moveLeft), forControlEvents: .TouchUpInside)
        monthView.addSubview(leftArrow)
        
        let rightArrow = UIButton()
        rightArrow.setImage(UIImage(named: "whiteRightArrow"), forState: .Normal)
        rightArrow.addTarget(self, action: #selector(moveRight), forControlEvents: .TouchUpInside)
        monthView.addSubview(rightArrow)
        
        constrain(monthView, monthLabel, leftArrow, rightArrow) { monthView, monthLabel, leftArrow, rightArrow in
            monthView.top    == monthView.superview!.top + 64
            monthView.left   == monthView.superview!.left
            monthView.right  == monthView.superview!.right
            monthView.height == 57
            
            monthLabel.center == monthLabel.superview!.center
            
            leftArrow.left    == leftArrow.superview!.left + 10
            leftArrow.centerY == leftArrow.superview!.centerY
            
            rightArrow.right   == rightArrow.superview!.right - 10
            rightArrow.centerY == rightArrow.superview!.centerY
        }
    }
    
    func moveLeft() {
        
    }
    
    func moveRight() {
        
    }
}


extension LoadHistoryViewController {
    func addSummary() {
        let loadLabel = UILabel()
        loadLabel.text = "Load Summary"
        loadLabel.textAlignment = .Left
        loadLabel.font = AppearanceManager.semiboldFont(20)
        loadLabel.textColor = AppearanceManager.sharedInstance.cerulean
        self.view.addSubview(loadLabel)
        
        let totalGrossLabel = UILabel()
        totalGrossLabel.text = "$35,000.00"
        totalGrossLabel.textAlignment = .Left
        totalGrossLabel.font = AppearanceManager.mediumFont(16)
        totalGrossLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(totalGrossLabel)
        
        let grossSalesLabel = UILabel()
        grossSalesLabel.text = "Gross Sales"
        grossSalesLabel.textAlignment = .Left
        grossSalesLabel.font = AppearanceManager.mediumFont(18)
        grossSalesLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(grossSalesLabel)
        
        constrain(loadLabel, totalGrossLabel, grossSalesLabel) { loadLabel, totalGrossLabel, grossSalesLabel in
            loadLabel.left == loadLabel.superview!.left + 8
            loadLabel.top  == loadLabel.superview!.top + 132
            
            totalGrossLabel.left == totalGrossLabel.superview!.left + 8
            totalGrossLabel.top  == loadLabel.bottom + 10
            
            grossSalesLabel.left == grossSalesLabel.superview!.left + 8
            grossSalesLabel.top  == loadLabel.bottom + 34
        }
        
        let totalLoadsLabel = UILabel()
        totalLoadsLabel.text = "40"
        totalLoadsLabel.textAlignment = .Left
        totalLoadsLabel.font = AppearanceManager.mediumFont(16)
        totalLoadsLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(totalLoadsLabel)
        
        let loads = UILabel()
        loads.text = "Loads"
        loads.textAlignment = .Left
        loads.font = AppearanceManager.mediumFont(18)
        loads.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(loads)
        
        constrain(loadLabel, totalLoadsLabel, loads) { loadLabel, totalLoadsLabel, loads in
            totalLoadsLabel.left == totalLoadsLabel.superview!.left + 168
            totalLoadsLabel.top  == loadLabel.bottom + 10
            
            loads.left == loads.superview!.left + 168
            loads.top  == loadLabel.bottom + 34
        }
        
        let priceLabel = UILabel()
        priceLabel.text = "$500.00"
        priceLabel.textAlignment = .Left
        priceLabel.font = AppearanceManager.mediumFont(16)
        priceLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(priceLabel)
        
        let averageLoadLabel = UILabel()
        averageLoadLabel.text = "Average Load"
        averageLoadLabel.textAlignment = .Left
        averageLoadLabel.font = AppearanceManager.mediumFont(18)
        averageLoadLabel.textColor = AppearanceManager.sharedInstance.brownishGrey
        self.view.addSubview(averageLoadLabel)
        
        constrain(loadLabel, priceLabel, averageLoadLabel) { loadLabel, priceLabel, averageLoadLabel in
            priceLabel.left == priceLabel.superview!.left + 248
            priceLabel.top  == loadLabel.bottom + 10
            
            averageLoadLabel.left == averageLoadLabel.superview!.left + 248
            averageLoadLabel.top == loadLabel.bottom + 34
        }
    }
    
    private func addSummaryLineChart() {
        barChartView.backgroundColor = AppearanceManager.sharedInstance.backgroundColor
        barChartView.leftAxis.enabled = true
        barChartView.rightAxis.enabled = false
        barChartView.pinchZoomEnabled = false
        barChartView.noDataText = "You need to provide data for the chart."

        self.addDataPoints(["1st", "10th", "15th", "20th", "25th", "30th"], values: [5.0, 17.0, 6.0, 10.0, 15.0, 7.0])

        self.view.addSubview(barChartView)
        
        constrain(barChartView) { barChartView in
            barChartView.centerX == barChartView.superview!.centerX
            barChartView.top     == barChartView.superview!.top + 214
            barChartView.height  == 120
            barChartView.width   == 320
        }
    }
    
    private func addDataPoints(dataPoints: [String], values: [Double]) {
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let barCharDataSet = BarChartDataSet(yVals: dataEntries, label: "Weeks")
        barCharDataSet.colors = [AppearanceManager.sharedInstance.cerulean]
        barCharDataSet.drawValuesEnabled = true

        barChartView.data = BarChartData(xVals: dataPoints, dataSet: barCharDataSet)
        
        barChartView.leftAxis.drawGridLinesEnabled = true
        barChartView.leftAxis.gridColor = UIColor(white: 210/255.0, alpha: 1.0)
        barChartView.leftAxis.labelTextColor = AppearanceManager.sharedInstance.brownishGrey
        barChartView.leftAxis.labelFont = AppearanceManager.lightFont(8.0)
        barChartView.leftAxis.axisMinValue = 0.0
        
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.xAxis.enabled = true
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.labelTextColor = AppearanceManager.sharedInstance.brownishGrey
        barChartView.xAxis.labelFont = AppearanceManager.lightFont(13.0)
        
        barChartView.legend.enabled = false
        barChartView.descriptionText = ""
     }
}

extension LoadHistoryViewController : UITableViewDataSource, UITableViewDelegate {
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
    
}