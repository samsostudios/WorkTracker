//
//  WorkViewController.swift
//  WorkTracker
//
//  Created by Sam Henry on 6/4/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import Firebase
import Hero
import BLTNBoard

class WorkViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    var projects = [project]()
    
    var currentBackground = (name: "Dimmed", style: BLTNBackgroundViewStyle.dimmed)
    
    lazy var bulletinManager: BLTNItemManager = {
       let addProjectPage = BulletinFunctions.makeTextFieldPage()
        return BLTNItemManager(rootItem: addProjectPage)
    }()
    
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    
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
        
        //Navbar setup
        let backButton = UIBarButtonItem()
        backButton.title = " "
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        //Tabbar setup
//        self.tabBarController?.tabBar.barTintColor = .clear
        self.tabBarController?.tabBar.layer.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.tabBarController?.tabBar.layer.masksToBounds = false
        self.tabBarController?.tabBar.layer.cornerRadius = 20
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //User icon setup
        let profHeight = profileImageView.frame.height
        profileImageView.layer.cornerRadius = profHeight/2
        
        //Overview Section setup
        bannerImageView.layer.cornerRadius = 15
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bannerImageView.addSubview(blurEffectView)
        
        //Button Setup
        let buttonHeight = addButton.frame.height
        addButton.layer.cornerRadius = buttonHeight/2
        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        addButton.layer.shadowRadius = 6.0
        addButton.layer.shadowOpacity = 0.1
        addButton.layer.masksToBounds = false
        
        //Hero Setup
        gradientImageView.hero.id = "gradientBG"
        bannerImageView.hero.id = "bannerBG"
        headerLabel.hero.id = "headerLBL"
        
        //Date Info
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        
        switch hour {
        case 0 ... 4:
//            print("evening")
            headerLabel.text = "Good Evening, Sam"
        case 5 ... 11:
//            print("morning")
            headerLabel.text = "Good Morning, Sam"
        case 12 ... 16:
//            print("afternoon")
            headerLabel.text = "Good Afternoon, Sam"
        case 17 ... 24:
//            print("evening")
            headerLabel.text = "Good Evening, Sam"
        default:
            print("default")
        }
        
        //Firebase Data Capture
        let projectsDBRef = Database.database().reference().child("Projects")
        
        projectsDBRef.observe(.childAdded) {
            snapshot in

//            print("SNAP", snapshot.value)

            let snapObject = snapshot.value as! NSDictionary

            //Project Names
            print("SNAP PROJECT", snapObject["Name"]!)
            let projectName = snapObject["Name"] as! String

            //Project Times
            print("SNAP TIME", snapObject["Time"]!)
            let timeObject = snapObject["Time"]! as! NSDictionary
            let projectHours = timeObject["Hours"] as! Int
            let projectMinutes = timeObject["Minutes"] as! Int

            //Update Class Array
            let projectObeject = project(name: projectName, hours: projectHours, minutes: projectMinutes)
            self.projects.append(projectObeject)

            self.jobsCollectionView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Navbar setup
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let cellSelected = jobsCollectionView?.indexPath(for: sender as! JobsCollectionViewCell)
            let projectDetail = segue.destination as! WorkDetailViewController
            
            projectDetail.projectName = self.projects[((cellSelected?.row)!)].name
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = jobsCollectionView.dequeueReusableCell(withReuseIdentifier: "jobCell", for: indexPath) as! JobsCollectionViewCell
        
        cell.layer.cornerRadius = 15
        cell.layer.masksToBounds = true
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOffset = CGSize(width: 1.0, height: 4.0)
        cell.layer.shadowRadius = 7.0
        cell.layer.shadowOpacity = 0.2
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        let name = projects[indexPath.row].name
        let hour = projects[indexPath.row].hours
        let h = String(hour)
        let minute = projects[indexPath.row].minutes
        let m = String(minute)
        
        cell.cellLabel.text = name
        cell.timeLabel.text = h + "h " + m  + "m"
        
        return cell
    }
}

extension WorkViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        let width = jobsCollectionView.frame.size.width
        let xInsets: CGFloat = 15
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width / columns) - (xInsets + cellSpacing), height: 175)
        
    }
}

class project {
    let name: String
    let hours: Int
    let minutes: Int
    
    init(name: String, hours: Int, minutes: Int) {
        self.name = name
        self.hours = hours
        self.minutes = minutes
    }
}
