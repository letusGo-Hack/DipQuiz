//
//  ContentView.swift
//  dipquiz
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var launchScreenState: LaunchScreenStateManager

    var body: some View {
        HomeView()
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
