//
//  QuizViewController.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit
import DQCommon

final class QuizViewController: UIViewController {
    private let wrapper = ConnectionManagerWrapper()
    
    private let mainView = QuizView()
    override func loadView() {
        view = mainView
        mainView.listener = self
        wrapper.listener = self
    }
}

extension QuizViewController: ConnectionManagerWrapperListener {
    func event(_ event: ConnectionManagerWrapperEvent) {
        
    }
}

extension QuizViewController: QuizViewListener {
    func action(_ action: QuizViewAction) {
        switch action {
        case let .answerTapped(answer):
            print("answerTapped")
        }
    }
}
