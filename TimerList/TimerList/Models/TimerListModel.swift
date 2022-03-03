//
//  TimerListModel.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import Foundation

class TimerListModel: ObservableObject {
    @Published var timerList = [Timer(sec: 100, isActive: true), Timer(sec: 400, isAlarmOn: true)]
    
}
