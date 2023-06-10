//
//  PendingViewController.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit

final class PendingViewController: UIViewController {
    private let mainView = PendingView()
    override func loadView() {
        view = mainView
        mainView.listener = self
    }
}

extension PendingViewController: PendingViewListener {
    func action(_ action: PendingViewAction) {
        switch action {
            
        }
    }
}
