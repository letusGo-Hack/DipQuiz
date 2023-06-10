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
    @State private var nickName = UserDefaultsManager.shared.loadText()

    var body: some View {
        VStack {
            Spacer()

            Text("\(nickName) 님 반갑습니다!")

            joinButton
                .frame(height: 64)
                .padding(.horizontal, 40)
            Spacer()
            NavigationLink(
                destination: PendingView(connectionManager: connectionManager),
                isActive: $connectionManager.connectedToChat,
                label: { EmptyView() }
            )
            .hidden()
        }.onAppear(){
            connectionManager.displayname("c1")//클라이언트 이름
        }
        .background(Color.white)
        .onChange(of: self.connectionManager.connectedToChat) { oldValue, newValue in
            print("⌘")
        }
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
}
