//
//  hostApp.swift
//  host
//
//  Created by zimeVX on 2023/06/10.
//

import SwiftUI
import SwiftData

@main
struct hostApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
