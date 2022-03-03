//
//  TimerListView.swift
//  TimerList
//
//  Created by 波多野充 on 2022/03/03.
//

import SwiftUI

struct TimerListView: View {
    @ObservedObject var model = TimerListModel()
    var body: some View {
        VStack {
            
            // 再開・停止ボタン
            
            
            // タイマーの一覧の表示
            ScrollView {
                VStack {
                    ForEach(model.timerList) { item in
                        TimerItemView(item: item)
                    }
                }
            }
        }
    }
}

struct TimerListView_Previews: PreviewProvider {
    static var previews: some View {
        TimerListView()
    }
}
