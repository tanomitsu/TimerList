//
//  Timer.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import Foundation

struct TimerItem: Identifiable, CustomStringConvertible, Equatable, Codable {
    var id = UUID()
    var sec: Int   // seconds of timer [s]
    var secLeft: Int    // seconds left [s]
    // var isActive: Bool = false      // whether timer is running
    var isAlarmOn: Bool = false     // whether alarm ringing screen shows
    
    var isMoveOn: Bool = false
    
    var min: Int {
        (secLeft / 60) % 60
    }
    
    var hour: Int {
        (secLeft / 3600) % 60
    }
    
    var description: String {
        // Printed text
        return String(format: "%02d:%02d:%02d", hour, min, secLeft % 60)
    }
    
    
    // initializers
    init(sec: Int, isActive: Bool = false, isAlarmOn: Bool = true) {
        self.sec = sec
        self.secLeft = sec
        self.isAlarmOn = isAlarmOn
    }
    
    // Equatable
    static func ==(lhs: TimerItem, rhs: TimerItem) -> Bool {
        return lhs.id == rhs.id
    }
}
