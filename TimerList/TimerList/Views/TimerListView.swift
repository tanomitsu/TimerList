//
//  TimerListView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

struct TimerListView: View {
    @ObservedObject var model: TimerListModel = TimerListModel()
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
                        
                        Button("削除") {
                            guard let activeIndex = model.activeIndex else { return }
                            model.deleteTimer(element: model.timerList[activeIndex])
                        }
                        
                        Button("バグ報告") {
                            
                        }
                        
                        Button("全削除") {
                            model.activeIndex = nil
                            self.model.timerList.removeAll()
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
                        ForEach(model.timerList.indices, id: \.self) { i in
                            TimerItemView(timerItem: $model.timerList[i], model: model)
                        }
                        
                        // "Add timer" button
                        Button(action: {
                            model.addTimer()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("新規タイマー")
                            }
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
            // UserDefaults.standard.removeAll()
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let timerListData = UserDefaults.standard.data(forKey: "timerList"),
                  let timerList = try? jsonDecoder.decode([TimerItem].self, from: timerListData) else { return }
            let activeIndex = UserDefaults.standard.integer(forKey: "activeIndex")
            
            
            model.timerList = timerList
            if activeIndex >= 0 {
                model.activeIndex = activeIndex
            } else {
                model.activeIndex = nil
            }
        }
        .onDisappear {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.keyEncodingStrategy = .convertToSnakeCase
            guard let timerListData = try? jsonEncoder.encode(model.timerList) else { return }
            UserDefaults.standard.set(timerListData, forKey: "timerList")
            UserDefaults.standard.set(model.activeIndex ?? -1, forKey: "activeIndex")
        }
    }
}

struct TimerListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}

extension UserDefaults {

    func removeAll() {
        dictionaryRepresentation().forEach{ removeObject(forKey: $0.key) }
    }
}
