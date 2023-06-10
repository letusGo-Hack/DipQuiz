//
//  ContentView.swift
//  host
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI
import SwiftData
import DQCommon

struct ContentView: View {
    var body: some View {
        NavigationStack {
            NavigationLink {
                ManagingView()
            } label: {
                Label("관리", systemImage: "square.stack.3d.up.fill")
                    .font(.system(size: 30, weight: .medium))
            }
            Spacer().frame(height: 20)
            NavigationLink {
                StartingView()
            } label: {
                Label("시작", systemImage: "flag.checkered")
                    .font(.system(size: 30, weight: .medium))
            }
        }.onAppear(){
            //호스트이름 고정
            ConnectionManager.shared.displayname("Dip Quiz Host")
            ConnectionManager.shared.host()
        }
    }
}

#Preview {
    ContentView()
}
