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

enum BulletinFunctions {
    static func makeTextFieldPage() -> TextFieldBulletinPage {
        
        let page = TextFieldBulletinPage(title: "New Project")
        page.isDismissable = true
        page.descriptionText = ""
        page.actionButtonTitle = "Create"
        page.appearance.actionButtonColor = Colors.lightBlue
        
        page.textInputHandler = { (item, text) in
            print("Text", text!)
            
            let uuid = UUID().uuidString
            print(uuid)
            
            let projectDBRef = Database.database().reference().child("Projects").child(text!)
            projectDBRef.child("name").setValue(text)
            
        }
        page.actionHandler = { (item: BLTNActionItem) in
            print("Action button tapped")
            item.manager?.dismissBulletin(animated: true)
        }
        
        return page
        
    }
}
