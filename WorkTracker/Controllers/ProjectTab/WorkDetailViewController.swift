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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        projectLabel.text = projectName
        
        //Navbar setup
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        //Hero Setup
        hero.isEnabled = true
        gradientImageView.hero.id = "gradientBG"
        
    }
}
