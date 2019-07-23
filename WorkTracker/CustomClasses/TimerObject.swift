//
//  TimerObject.swift
//  WorkTracker
//
//  Created by Sam Henry on 7/22/19.
//  Copyright © 2019 Sam Henry. All rights reserved.
//

import Foundation

class TimerObject {
    let minutes: Int
    let hours: Int
    let startTime: String
    let endTime: String
    let day: String
    
    init(minutes: Int, hours: Int, startTime: String, endTime: String, day: String){
        
        self.minutes = minutes
        self.hours = hours
        self.startTime = startTime
        self.endTime = endTime
        self.day = day
    }
}
