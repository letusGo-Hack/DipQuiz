//
//  dipquizApp.swift
//  dipquiz
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI

@main
struct dipquizApp: App {
    @StateObject var launchScreenState = LaunchScreenStateManager()

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()

                if launchScreenState.state != .finished {
                    LaunchScreenView()
                }
            }.environmentObject(launchScreenState)
        }
    }
}
