//
//  PendingViewController.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit
import DQCommon

final class PendingViewController: UIViewController {
    private let wrapper = ConnectionManagerWrapper()
    private let mainView = PendingView()
    override func loadView() {
        view = mainView
        mainView.listener = self
        wrapper.listener = self
    }
    
    private func stopLoading() {
        wrapper.listener = nil
    }
}

extension PendingViewController: PendingViewListener {
    func action(_ action: PendingViewAction) {
        switch action {
            
        }
    }
}

extension PendingViewController: ConnectionManagerWrapperListener {
    func event(_ event: ConnectionManagerWrapperEvent) {
        switch event {
        case let .messagesChanged(commands):
            if let firstCommand = commands.first,
               firstCommand.type == .INT {
                stopLoading()
            }
        default:
            break
        }
    }
}
