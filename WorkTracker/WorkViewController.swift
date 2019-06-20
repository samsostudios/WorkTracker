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
    
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var jobsCollectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addBiuttonAction(_ sender: UIButton) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.darkSecondary
        
        self.tabBarController?.tabBar.barTintColor = Colors.darkPrimary
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.layer.cornerRadius = 15
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        let profHeight = profileImageView.frame.height
        profileImageView.layer.cornerRadius = profHeight/2
        
        bannerImageView.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bannerImageView.addSubview(blurEffectView)
        
        let buttonHeight = addButton.frame.height
        addButton.layer.cornerRadius = buttonHeight/2
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        addButton.layer.shadowRadius = 6.0
        addButton.layer.shadowOpacity = 0.1
        addButton.layer.masksToBounds = false
        
//        let floaty = Floaty()
//        floaty.addItem("Hello, World!", icon: UIImage(named: "plus")!)
//        self.view.addSubview(floaty)
        
//        let date = Date()
//        let calendar = Calendar.current
//        let amPM = calendar.component(.era, from: date)
//        let hour = calendar.component(.hour, from: date)
//        let minutes = calendar.component(.minute, from: date)
//        let seconds = calendar.component(.second, from: date)
//        print("DATE", calendar.identifier)
       
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath) as! JobsCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        cell.layer.shadowRadius = 6.0
        cell.layer.shadowOpacity = 0.1
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
}

extension WorkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        let width = jobsCollectionView.frame.size.width
        let xInsets: CGFloat = 15
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width / columns) - (xInsets + cellSpacing), height: 250)
        
    }
}
