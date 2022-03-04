//
//  TimerSetView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/04.
//

import SwiftUI

struct TimerSetView: View {
    @EnvironmentObject var model: TimerListModel
    @Binding var isPresented: Bool
    @Binding var timerItem: TimerItem
    @State var hour: Int = 0
    @State var min: Int = 0
    @State var sec: Int = 0
    @State var openingWheel: Int = 3
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("SettingBackground")
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        
                        // hour
                        Button(action: {
                            openingWheel = 1
                        }){
                            Text(String(format: "%02d", hour))
                                .foregroundColor(openingWheel == 1 ? Color("LetterColor") : Color("NotSelectedColor"))
                                .font(openingWheel == 1 ? .largeTitle : .title)
                        }
                        
                        Text(":")
                            .foregroundColor(Color("NotSelectedColor"))
                        
                        // min
                        Button(action: {
                            openingWheel = 2
                        }){
                            Text(String(format: "%02d", min))
                                .foregroundColor(openingWheel == 2 ? Color("LetterColor") : Color("NotSelectedColor"))
                                .font(openingWheel == 2 ? .largeTitle : .title)
                        }
                        
                        Text(":")
                            .foregroundColor(Color("NotSelectedColor"))
                        
                        // sec
                        Button(action: {
                            openingWheel = 3
                        }){
                            Text(String(format: "%02d", sec))
                                .foregroundColor(openingWheel == 3 ? Color("LetterColor") : Color("NotSelectedColor"))
                            .font(openingWheel == 3 ? .largeTitle : .title)
                        }
                    }
                    
                    Spacer()
                    
                    if (openingWheel == 1) {
                        VStack{
                            Picker(selection: $hour, label: Text("時間")) {
                                ForEach(0..<60, id: \.self) { num in
                                    Text(String(format: "%02d", num))
                                }
                            }.pickerStyle(.wheel)
                            Text("時間")
                                .font(.headline)
                        }
                    } else if (openingWheel == 2) {
                        VStack{
                            Picker(selection: $min, label: Text("時間")) {
                                ForEach(0..<60, id: \.self) { num in
                                    Text(String(format: "%02d", num))
                                }
                            }.pickerStyle(.wheel)
                            Text("分")
                                .font(.headline)
                        }
                    } else if (openingWheel == 3) {
                        VStack{
                            Picker(selection: $sec, label: Text("時間")) {
                                ForEach(0..<60, id: \.self) { num in
                                    Text(String(format: "%02d", num))
                                }
                            }.pickerStyle(.wheel)
                            Text("秒")
                                .font(.headline)
                        }
                    }
                        
                }.font(.title)
                    .toolbar {
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("キャンセル") {
                                isPresented = false
                            }
                            .foregroundColor(Color("CancelLetterColor"))
                        }
                        
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button("保存") {
                                if hour == 0 && min == 0 && sec == 0 {
                                    // do nothing
                                } else {
                                    // set new time
                                    timerItem.sec = 3600 * hour + 60 * min + sec
                                    timerItem.secLeft = timerItem.sec
                                    isPresented = false
                                }
                            }
                        }
                    }
            }
        }
    }
    
    init(isPresented: Binding<Bool>, timerItem: Binding<TimerItem>) {
        self._isPresented = isPresented
        self._timerItem = timerItem
        let hour_init = (self.timerItem.sec / 3600) % 60
        let min_init = (self.timerItem.sec / 60) % 60
        self._hour = State(initialValue: hour_init)
        self._min = State(initialValue: min_init)
        self._sec = State(initialValue: self.timerItem.sec % 60)
    }
}
