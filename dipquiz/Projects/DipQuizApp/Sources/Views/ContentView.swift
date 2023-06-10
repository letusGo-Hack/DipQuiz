//
//  ContentView.swift
//  dipquiz
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI
import DQCommon

struct ContentView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager
    @StateObject var appState = AppState()
    
    var body: some View {
        NavigationView {
            Group {
                switch (appState.switchView) {
                case .join:
                    JoinView()
                        .environmentObject(appState)
                case .home:
                    HomeView()
                        .environmentObject(appState)
                    
                case let .pending(manager):
                    PendingView(connectionManager: manager)
                        .environmentObject(appState)
                    
                case .quiz:
                    QuizView()
                        .environmentObject(appState)
                case .result:
                    QuizView()
                        .environmentObject(appState)
                }
            }
        }
        .task {
            try? await Task.sleep(for: Duration.seconds(1))
            self.launchScreenState.dismiss()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(LaunchScreenStateManager())
}
