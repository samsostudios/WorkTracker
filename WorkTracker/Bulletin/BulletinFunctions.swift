//
//  BulletinFunctions.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/11/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import BLTNBoard
import Firebase

let info: [projectInfo] = []
var pName = ""
var pRate = ""

enum BulletinFunctions {
    static func makeTextFieldPage() -> TextFieldBulletinPage {
        
        let page = TextFieldBulletinPage(title: "New Project")
        page.image = #imageLiteral(resourceName: "plus")
        page.isDismissable = true
        page.descriptionText = ""
        page.actionButtonTitle = "Continue"
        page.appearance.actionButtonColor = Colors.lightBlue
        
        page.textInputHandler = { (item, text) in
            print("Text", text!)
            
            pName = text!
            
        }
        page.actionHandler = { (item: BLTNActionItem) in
            print("Action button tapped")
//            item.manager?.dismissBulletin(animated: true)
            
            if pName == "" {
                print("No text")
            }else{
                print(pName)
                item.manager?.displayNextItem()
            }
            
        }
        
        page.next = makeRatePage()
        
        return page
        
    }
    
    static func makeRatePage() -> TextFieldBulletinPage {
        let page = TextFieldBulletinPage(title: "Set Hourly Rate")
        page.isDismissable = true
        page.descriptionText = ""
        page.actionButtonTitle = "Create"
        page.appearance.actionButtonColor = Colors.lightBlue
        
        page.textInputHandler = { (item, text) in
            
            pRate = text!
            
        }
        
        page.actionHandler = { (item: BLTNActionItem) in
            
            if pRate == "" {
                print("No text")
            }else{
                let name = pName
                let rate = pRate
                let hours = 0
                let minutes = 0
                let newProject = ["Name": name, "Rate": rate ,"Time": ["Hours": hours, "Minutes": minutes]] as [String : Any]
                
                print("NEW P", newProject)
                
                let projectDBRef = Database.database().reference().child("Projects").child(name)
                
                projectDBRef.setValue(newProject)
                
                item.manager?.dismissBulletin(animated: true)
            }
            
        }
        
        return page
    }
}

class projectInfo {
    let name: String
    let rate: String
    
    init(name: String, rate: String) {
        self.name = name
        self.rate = rate
    }
}
