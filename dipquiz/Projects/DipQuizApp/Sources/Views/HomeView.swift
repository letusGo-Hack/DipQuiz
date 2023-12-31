//
//  HomeView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI
import DQCommon

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @ObservedObject private var connectionManager = ConnectionManager.shared
    
    var body: some View {
        VStack {
            Spacer()
//            Text("\(UserDefaultsManager.shared.loadText()) 님 반갑습니다!")
            joinButton
                .frame(height: 64)
                .padding(.horizontal, 40)
            sendButton
                .frame(height: 64)
                .padding(.horizontal, 40)
            Spacer()
        }.onAppear(){
            connectionManager.displayname("c1")
//            if connectionManager.onFinsh {
//                print("")
//            }
        }
        .onReceive(connectionManager.$connectedToChat) { isConnected in
//            if isConnected {
//                appState.switchView = .pending(connectionManager)
//            }
        }
        .background(Color.white)
    }

    private var joinButton: some View {
        Button(action: joinButtonTapped) {
            Text("Join")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .cornerRadius(8)
        }
    }

    private func joinButtonTapped() {
        print("Join Button Tapped")
        ConnectionManager.shared.join()
    }
    
    private var sendButton: some View {
        Button(action: sendButtonTapped) {
            Text("sendTest")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .cornerRadius(8)
        }
    }
    private func sendButtonTapped() {
        print("Join Button Tapped")
        ConnectionManager.shared.send(_question_id: "ID112", _question: "코리리코는길다", _answer: "아니다/맞다", _value: "맞다", _type: .INT)
    }
}
