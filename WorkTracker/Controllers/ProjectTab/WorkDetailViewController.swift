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

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var startTimerButton: UIButton!
    
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
