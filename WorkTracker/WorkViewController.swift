//
//  WorkViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 6/4/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import Firebase
import FloatingPanel
import Hero

class WorkViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var jobsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        
        self.tabBarController?.tabBar.barTintColor = Colors.darkPrimary
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.layer.cornerRadius = 15
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let profHeight = profileImageView.frame.height
        profileImageView.layer.cornerRadius = profHeight/2
        
        let date = Date()
        let calendar = Calendar.current
        let amPM = calendar.component(.era, from: date)
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        print("DATE", calendar.amSymbol)
       
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath) as! JobsCollectionViewCell
        return cell
    }

}
