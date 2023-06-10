//
//  LaunchScreenStateManager.swift
//  dipquiz
//
//  Created by Derrick kim on 2023/06/10.
//

import Foundation

final class LaunchScreenStateManager: ObservableObject {
@MainActor @Published private(set) var state: LaunchScreenStep = .firstStep

    @MainActor func dismiss() {
        Task {
            state = .secondStep

            try? await Task.sleep(for: Duration.seconds(1))

            self.state = .finished
        }
    }
}
