//
//  dipquizApp.swift
//  dipquiz
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI
import DQCommon

@main
struct dipquizApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()
    @StateObject private var modelData = ConnectionManager.shared

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .environmentObject(modelData)

                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
