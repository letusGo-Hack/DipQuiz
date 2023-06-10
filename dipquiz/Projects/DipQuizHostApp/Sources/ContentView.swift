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
    
    @EnvironmentObject var modelData: ConnectionManager
    
    var body: some View {
        NavigationStack {
            NavigationLink {
                ManagingView()
                    .modelContainer(for: [
                        QuestionModel.self
                    ])
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
            
            ForEach(modelData.messages) { message in
                Group{}
            }

//            ForEach(modelData.messages) { message in
//              MessageBodyView(message: message)
//                .onAppear {
//                  if message == chatConnectionManager.messages.last {
//                    reader.scrollTo(message.id)
//                  }
//                }
//            }
            
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
