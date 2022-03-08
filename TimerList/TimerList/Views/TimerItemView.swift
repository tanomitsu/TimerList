//
//  TimerItemView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

struct TimerItemView: View {
    @Binding var timerItem: TimerItem
    @ObservedObject var model: TimerListModel
    @State var isShow: Bool = false
    @State var openingWhell: Int = 1
    var body: some View {
        HStack {
            
            // cursor
            Button(action: {
                model.setCursor(to: &timerItem)
            }){
                let cursorName = (model.activeIndex != nil && model.timerList[model.activeIndex!] == timerItem) ? "arrow.forward.circle.fill" : "circle"
                Image(systemName: cursorName)
                    .resizable()
                    .frame(width: 25.0, height: 25.0)
                    .padding(.leading, 10)
            }
            
            // time left
            Button(action: {
                isShow = true
            }){
                Text(timerItem.description)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(width: 200)
                
            }
            .sheet(isPresented: $isShow) {
                TimerSetView(isPresented: $isShow, timerItem: $timerItem, model: model)
            }
            // bell symbol
            Button(action: {
                self.timerItem.isAlarmOn.toggle()
            }){
                let imageName = timerItem.isAlarmOn ? "bell.fill" : "bell.slash.fill"
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .padding(.trailing, 10)
            }
            
            // MoveOn symbol
            Button(action: {
                self.timerItem.isMoveOn.toggle()
            }){
                let imageName = timerItem.isMoveOn ? "arrow.down.circle" : "arrow.down.to.line.circle.fill"
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 30.0, height: 30.0)
                    .padding(.trailing, 10)
            }
            
        }
        .background(Color("timerItemBackground"))
        .cornerRadius(10.0)
        .foregroundColor(Color("LetterColor"))
    }
}
