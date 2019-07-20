//
//  IncomeViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/17/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import Charts

class IncomeViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var chartView: LineChartView!
    @IBOutlet weak var tableView: UITableView!
    
    let months = ["Jan", "Feb", "Mar", "Apr"]
    
    let data = [200, 300, 576, 75]
//    let tags = [0, 1, 2, 3]
    
    var chartData: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        
        setChartData(tags: months, data: data)
        
        //Table View Setup
        tableView.backgroundColor = .clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.rowHeight = 100.0
        
    }
    
    func setChartData(tags: [String], data: [Int]){
        
        print(tags.count)
        
        for i in 0 ..< data.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(data[i]))
            chartData.append(dataPoint)
        }
        
        let dataMin: Int = data.min()!
        let dataMax: Int = data.max()!
        let dataAverage: Int = (dataMax + dataMin) / 2
        let dataDiff: Int = dataMax - dataMin
        print("Data", dataMin, dataMax, dataAverage, dataDiff)
        
        print("DATA", chartData)
        let chartDataSet = LineChartDataSet(entries: chartData, label: "")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [Colors.lightPrimary]
        chartDataSet.setCircleColor(Colors.lightPrimary)
        chartDataSet.circleHoleColor = Colors.lightPrimary
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.circleRadius = 5.0
        chartDataSet.valueFont = UIFont(name: "Avenir Next", size: 15.0)!
        chartDataSet.valueColors = [Colors.lightPrimary]
        chartDataSet.highlightEnabled = true
        chartDataSet.lineWidth = 3.0
        
        let formatter = chartFormatter()
        formatter.setValues(values: tags)
        let xaxis:XAxis = XAxis()
        
        xaxis.valueFormatter = formatter
        
        chartView.legend.enabled = false
        chartView.xAxis.labelPosition = .bottom
//        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
//        chartView.xAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.valueFormatter = xaxis.valueFormatter
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.labelFont = UIFont(name: "AvenirNext-Bold", size: 12.0)!
        chartView.xAxis.labelTextColor = Colors.lightPrimary
        chartView.xAxis.spaceMin = 0.2
        chartView.xAxis.spaceMax = 0.2
        chartView.xAxis.axisLineWidth = 0.0

        chartView.leftAxis.axisLineWidth = 0.0
        chartView.leftAxis.axisMinimum = Double(dataMin - 100)
        chartView.leftAxis.axisMaximum = Double(dataMax + 100)
        chartView.leftAxis.granularityEnabled = true
        chartView.leftAxis.granularity = Double(dataMax/2)
        chartView.leftAxis.labelFont = UIFont(name: "AvenirNext-Bold", size: 12.0)!
        chartView.leftAxis.labelTextColor = Colors.lightPrimary
        chartView.leftAxis.axisLineWidth = 0.0
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.leftAxis.gridLineWidth = 1.0
        chartView.leftAxis.gridLineDashLengths = [10.0]
        chartView.leftAxis.gridColor = Colors.lightPrimary
        chartView.leftAxis.gridLineCap = .round
        
        let numberOfPoints = Double(tags.count)
        
        let animationSpeed = numberOfPoints * 0.06
        print("speed", animationSpeed)
        chartView.animate(xAxisDuration: animationSpeed, yAxisDuration: animationSpeed, easingOption: .easeInSine)
        
        let gradientColors = [Colors.lightPrimary.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        chartView.data = chartData
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! IncomeOverviewTableViewCell

        return cell
    }
}

class chartFormatter: NSObject, IAxisValueFormatter {
    var months = [String]()
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
    
    func setValues(values: [String])
    {
        self.months = values
    }
}
