//
//  AppState.swift
//  DipQuiz
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import Foundation
import DQCommon
class AppState: ObservableObject {
    enum CurrentView {
        case home
        case pending(ConnectionManager)
        case quiz
        case result
    }
    
    @Published var switchView = CurrentView.home
}
