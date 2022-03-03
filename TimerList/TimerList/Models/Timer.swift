//
//  Timer.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import Foundation

struct Timer: Identifiable, CustomStringConvertible {
    var id = UUID()
    var sec: Int   // seconds of timer [s]
    var secLeft: Int    // seconds left [s]
    var isActive: Bool = false      // whether timer is running
    var isAlarmOn: Bool = false     // whether alarm rings when the timer ends
    
    var min: Int {
        (secLeft / 60) % 60
    }
    
    var hour: Int {
        (secLeft / 3600) % 60
    }
    
    var description: String {
        // Printed text
        return String(format: "%02dh %02dm %02ds", hour, min, secLeft % 60)
    }
    
    
    // initializers
    init(sec: Int, isActive: Bool = false, isAlarmOn: Bool = true) {
        self.sec = sec
        self.secLeft = sec
        self.isActive = isActive
        self.isAlarmOn = isAlarmOn
    }
    
}
