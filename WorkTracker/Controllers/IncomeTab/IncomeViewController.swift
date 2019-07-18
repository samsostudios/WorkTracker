//
//  IncomeViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/17/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import Charts

class IncomeViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    
    let months = ["Jan", "Feb", "Mar", "Apr"]
    
    let data = [200, 100, 500, 300]
//    let tags = [0, 1, 2, 3]
    
    var chartData: [ChartDataEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        
        setChartData(tags: months, data: data)
    }
    
    func setChartData(tags: [String], data: [Int]){
        print("TAGS", tags)
        
        for i in 0 ..< data.count {
            let dataPoint = ChartDataEntry(x: Double(i), y: Double(data[i]))
            chartData.append(dataPoint)
        }
        
        print("DATA", chartData)
        let chartDataSet = LineChartDataSet(entries: chartData, label: "")
        let chartData = LineChartData()
        chartData.addDataSet(chartDataSet)
        chartData.setDrawValues(true)
        chartDataSet.colors = [Colors.lightPrimary]
        chartDataSet.setCircleColor(Colors.lightSecondary)
        chartDataSet.circleHoleColor = Colors.lightSecondary
        chartDataSet.mode = .cubicBezier
        chartDataSet.cubicIntensity = 0.2
        chartDataSet.circleRadius = 5.0
        chartDataSet.valueFont = UIFont(name: "Avenir Next", size: 15.0)!
        chartDataSet.highlightEnabled = false
        chartDataSet.lineWidth = 4.0
        
        let formatter = chartFormatter()
        formatter.setValues(values: tags)
        let xaxis:XAxis = XAxis()
        
        xaxis.valueFormatter = formatter
        
        chartView.xAxis.labelPosition = .bottom
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
//        chartView.xAxis.enabled = false
        chartView.xAxis.labelPosition = .bottom
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.valueFormatter = xaxis.valueFormatter
        chartView.legend.enabled = false
        chartView.xAxis.granularityEnabled = true
        chartView.xAxis.granularity = 1.0
        chartView.xAxis.labelFont = UIFont(name: "AvenirNext-Bold", size: 12.0)!
        chartView.xAxis.labelTextColor = Colors.lightPrimary
        chartDataSet.lineWidth = 2
        
        let gradientColors = [Colors.lightPrimary.cgColor, UIColor.clear.cgColor] as CFArray
        let colorLocations:[CGFloat] = [1.0, 0.0]
        let gradient = CGGradient.init(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        
        chartDataSet.fill = Fill.fillWithLinearGradient(gradient!, angle: 90.0)
        chartDataSet.drawFilledEnabled = true
        
        chartView.data = chartData
        
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
