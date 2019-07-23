//
//  WorkDetailViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/12/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit

class WorkDetailViewController: UIViewController {
    
    var projectName = ""
    
    var timer = Timer()
    
    var currentTimer = 0

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var startTimerButton: UIButton!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBAction func startTimer(_ sender: UIButton) {
        startTimerButton.isSelected = !startTimerButton.isSelected
        
        var minutes = 0
        var hours = 0
        var startTime = ""
        var endTime = ""
        var day = ""
        
        
        if(startTimerButton.isSelected == true){
            
            let date = Date()
            
            let dayFormatter: DateFormatter = DateFormatter()
            dayFormatter.dateFormat = "EEE, MMM d, yy"
            day = dayFormatter.string(from: date)
            print("day", day)
            
            let timeFormatter : DateFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm:ss a"
            startTime = timeFormatter.string(from: date)
            print(startTime)

            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
                timer in
                
                timer.tolerance = 0.2
                
                self.currentTimer += 1
                print(self.currentTimer)

                
                if(self.currentTimer == 60) {
                    minutes += 1
                    self.currentTimer = 0
                    print(minutes, self.currentTimer)
                }
                
                if(minutes == 60) {
                    hours += 1
                    minutes = 0
                    self.currentTimer = 0
                }
                
                print("Hours", hours, "Minutes", minutes, "Seconds", self.currentTimer)
            }
            
        }
        if(startTimerButton.isSelected == false){
            
            let timeFormatter : DateFormatter = DateFormatter()
            timeFormatter.dateFormat = "h:mm:ss a"
            let date = Date()
            endTime = timeFormatter.string(from: date)
            print(endTime)
            timer.invalidate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        projectLabel.text = projectName
        
        //Gradient Image Setup
        gradientImageView.layer.cornerRadius = 15
        
        //Banner Image Setup
        bannerImageView.layer.cornerRadius = 15
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bannerImageView.addSubview(blurEffectView)
        

        bannerImageView.layer.shadowColor = UIColor.black.cgColor
        bannerImageView.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        
        //Navbar setup
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Hero Setup
        hero.isEnabled = true
        gradientImageView.hero.id = "gradientBG"
        bannerImageView.hero.id = "bannerBG"
        projectLabel.hero.id = "headerLBL"
        
        //Start button setup
        let buttonHeight = startTimerButton.frame.height
        startTimerButton.layer.cornerRadius = buttonHeight/2
        
        let buttonBlur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffect.Style.dark))
        buttonBlur.frame = startTimerButton.bounds
        buttonBlur.isUserInteractionEnabled = false
        buttonBlur.layer.cornerRadius = buttonHeight/2
        buttonBlur.clipsToBounds = true
        startTimerButton.insertSubview(buttonBlur, at: 0)
        
    }
    
}
