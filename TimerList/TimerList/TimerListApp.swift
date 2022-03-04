//
//  TimerListApp.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

@main
struct TimerListApp: App {
    var body: some Scene {
        WindowGroup {
            TimerListView().environmentObject(TimerListModel())
        }
    }
}
