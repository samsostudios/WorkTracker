//
//  FeedbackPageBulletinItem.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/11/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import UIKit
import BLTNBoard

/**
 * A subclass of page bulletin item that plays an haptic feedback when the buttons are pressed.
 *
 * This class demonstrates how to override `PageBLTNItem` to customize button tap handling.
 */

class FeedbackPageBLTNItem: BLTNPageItem {
    
    private let feedbackGenerator = UISelectionFeedbackGenerator()
    
    override func actionButtonTapped(sender: UIButton) {
        
        // Play an haptic feedback
        
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
        
        // Call super
        
        super.actionButtonTapped(sender: sender)
        
    }
    
    override func alternativeButtonTapped(sender: UIButton) {
        
        // Play an haptic feedback
        
        feedbackGenerator.prepare()
        feedbackGenerator.selectionChanged()
        
        // Call super
        
        super.alternativeButtonTapped(sender: sender)
        
    }
    
}
