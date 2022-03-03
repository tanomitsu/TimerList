//
//  TimerItemView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

struct TimerItemView: View {
    var timerItem: Timer
    var color: Color
    
    var body: some View {
        HStack {
            Spacer()
            
            Circle()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(color)
            
            Spacer()
            
            Text(timerItem.description)
                .font(.title)
            
            Spacer()
            
            // bell symbol
            let imageName = timerItem.isAlarmOn ? "bell.fill" : "bell"
            Image(systemName: imageName)
                .resizable()
                .frame(width: 20.0, height: 20.0)
            
            Spacer()
        }.background(Color("timerItemBackground"))
    }
    
    init(item: Timer) {
        timerItem = item
        color = timerItem.isActive ? Color(.red) : Color(.gray)
    }
}

struct TimerItemView_Previews: PreviewProvider {
    static var previews: some View {
        TimerItemView(item: Timer(sec: 100, isActive: true))
    }
}
