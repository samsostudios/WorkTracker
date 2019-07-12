//
//  BulletinFunctions.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/11/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import BLTNBoard

enum BulletinFunctions {
    static func makeTextFieldPage() -> TextFieldBulletinPage {
        
        let page = TextFieldBulletinPage(title: "New Project")
        page.isDismissable = true
        page.descriptionText = ""
        page.actionButtonTitle = "Create"
        
        
        page.textInputHandler = { (item, text) in
            print("Text: \(text ?? "nil")")
            //            let datePage = self.makeDatePage(userName: text)
            //            item.manager?.push(item: datePage)
        }
        
        
        return page
        
    }
}
