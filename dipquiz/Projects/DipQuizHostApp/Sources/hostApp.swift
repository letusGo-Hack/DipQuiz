//
//  hostApp.swift
//  host
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI
import SwiftData
import DQCommon

@main
struct hostApp: App {
    @StateObject private var modelData = ConnectionManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
        .modelContainer(for: Item.self)
    }
}
