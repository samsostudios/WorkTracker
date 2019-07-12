//
//  WorkViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 6/4/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import Firebase
//import FloatingPanel
import Hero
import BLTNBoard

class WorkViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var currentBackground = (name: "Dimmed", style: BLTNBackgroundViewStyle.dimmed)
    
    lazy var bulletinManager: BLTNItemManager = {
       let addProjectPage = BulletinFunctions.makeTextFieldPage()
        return BLTNItemManager(rootItem: addProjectPage)
    }()
    
    
    
    @IBOutlet weak var bannerImageView: UIImageView!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var jobsCollectionView: UICollectionView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addBiuttonAction(_ sender: UIButton) {
        print("Add tapped")
//        makeTextFieldPage()
        showBulletin()
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
        
    }
    
    func showBulletin() {

        //        Uncomment to customize interface
        //        bulletinManager.cardCornerRadius = 22
        //        bulletinManager.edgeSpacing = .none
        //        bulletinManager.allowsSwipeInteraction = false
        //        bulletinManager.hidesHomeIndicator = true
        let bltnColor = Colors.darkSecondary as UIColor
        bulletinManager.backgroundColor = bltnColor
        bulletinManager.backgroundViewStyle = currentBackground.style
        bulletinManager.showBulletin(above: self)
//        bulletinManager.backgroundColor = Colors.darkPrimary

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

//class TextFieldBulletinPage: BLTNPageItem {
//    var nameTextField: UITextField!
//
//    override func makeViewsUnderDescription(with interfaceBuilder: BLTNInterfaceBuilder) -> [UIView]? {
//        nameTextField = interfaceBuilder.makeTextField(placeholder: "Project Name", returnKey: .done, delegate: (self as! UITextFieldDelegate))
//        return [nameTextField]
//    }
//}
