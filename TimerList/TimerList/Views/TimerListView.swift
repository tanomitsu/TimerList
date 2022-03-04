//
//  TimerListView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

struct TimerListView: View {
    @EnvironmentObject var model: TimerListModel
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HStack {
                    
                    Text("タイマーリスト")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color("LetterColor"))
                        .padding()
                    
                    Spacer()
                    Menu {
                        Button("編集") {
                            
                        }
                        
                        Button("バグ報告") {
                            
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 4.0, alignment: .trailing)
                            .padding()
                    }
                    .foregroundColor(Color(.black))
                }
                .background(Color("TitleBarBackground"))
                
                Divider()
                    
                
                // タイマーの一覧の表示
                ScrollView {
                    VStack {
                        ForEach(model.timerList.indices) { i in
                            TimerItemView(timerItem: $model.timerList[i])
                        }
                    }
                }
                
                if (model.timerRunning) {
                    
                    // 終了ボタン
                    Button(action: {
                        model.stopTimer()
                    }){
                        Text("ストップ")
                            .font(.largeTitle)
                            .bold()
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                            .foregroundColor(Color(.white))
                            .background(Color("EndButtonBackground"))
                            .cornerRadius(20)
                    }
                } else {
                    
                    // 開始ボタン
                    Button(action: {
                        model.startTimer()
                    }){
                        Text("スタート")
                            .font(.largeTitle)
                            .bold()
                            .padding(EdgeInsets(top: 10, leading: 40, bottom: 10, trailing: 40))
                            .foregroundColor(Color(.white))
                            .background(Color("StartButtonBackground"))
                            .cornerRadius(20)
                    }
                }
            }
        }
        .onAppear {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let timerListData = UserDefaults.standard.data(forKey: "timerList"),
                  let timerList = try? jsonDecoder.decode([TimerItem].self, from: timerListData) else { return }
            let activeIndex = UserDefaults.standard.integer(forKey: "activeIndex")
            
            model.timerList = timerList
            model.activeIndex = activeIndex
        }
        .onDisappear {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
            guard let timerListData = try? jsonEncoder.encode(model.timerList) else { return }
            UserDefaults.standard.set(timerListData, forKey: "timerList")
            UserDefaults.standard.set(model.activeIndex, forKey: "activeIndex")
        }
    }
}

struct TimerListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
