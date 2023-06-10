//
//  PendingView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI
import DQCommon

struct PendingView: View {
    @ObservedObject var connectionManager: ConnectionManager
    @EnvironmentObject var appState: AppState
    var body: some View {
        NavigationStack {
            HStack {
                Rectangle().foregroundColor(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle().foregroundColor(Color.red)
                    .frame(width: 100, height: 100)
                Rectangle().foregroundColor(Color.red)
                    .frame(width: 100, height: 100)
            }.onReceive(connectionManager.$messages) { messages in
                // Handle changes to the messages array
                guard let first = messages.first else { return }
                switch first.type {
                case .INT:
                    appState.switchView = .quiz
                default:
                    appState.switchView = .pending(connectionManager)
                }
            }
        }
        
    }
}
