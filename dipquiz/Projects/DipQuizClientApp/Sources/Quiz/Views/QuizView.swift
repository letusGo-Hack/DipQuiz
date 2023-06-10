//
//  QuizView.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit
import DQCommon
enum QuizViewAction {
    case answerTapped(String)
}

protocol QuizViewListener: AnyObject {
    func action(_ action: QuizViewAction)
}

final class QuizView: UIView {
    init() {
        super.init(frame: .zero)
        setupViews()
        define()
//        configure(question: "Hello", answers: [
//            "world1",
//            "world2",
//            "world3",
//            "world4",
//            "world5",
//        ])
        configureOX(question: "HelloHelloHelloHelloHello")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var listener: QuizViewListener?
    func configure(question: String, answers: [String]) {
        questionTitleLabel.text = question
        generateButton(answers: answers)
    }
    
    func configureOX(question: String) {
        answerStackView.isHidden = true
        answerOXStackView.isHidden = false
    }
    
    private let questionTitleLabel = UILabel()
    private let answerStackView = UIStackView()
    private let answerOXStackView = UIStackView()
    private var answerButtons = [UIButton]()
    private let answerOButton = UIButton(type: .system)
    private let answerXButton = UIButton(type: .system)
    
    private func generateButton(answers: [String]) {
        answerButtons.forEach {
            answerStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        answerButtons = []
        answers.forEach {
            let button = UIButton(type: .system)
            button.setTitle($0, for: .normal)
            button.backgroundColor = .lightGray
            button.translatesAutoresizingMaskIntoConstraints = false
            button.layer.cornerRadius = 26
            button.layer.masksToBounds = true
            button.addTarget(self, action: #selector(answerButtonTapped), for: .touchUpInside)
            answerButtons.append(button)
            answerStackView.addArrangedSubview(button)
            button.heightAnchor.constraint(equalToConstant: 52).isActive = true
        }
    }
    
    @objc
    private func answerButtonTapped(button: UIButton) {
        guard let answer = button.title(for: .normal),
              !answer.isEmpty else { return }
        listener?.action(.answerTapped(answer))
    }
}

private extension QuizView {
    func setupViews() {
        backgroundColor = .white
        questionTitleLabel.text = "현재 다른 참여자를 기다리는 중입니다."
        questionTitleLabel.textColor = .black
        questionTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        answerStackView.axis = .vertical
        answerStackView.spacing = 12
        answerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        answerOXStackView.axis = .horizontal
        answerOXStackView.spacing = 12
        answerOXStackView.translatesAutoresizingMaskIntoConstraints = false
        answerOXStackView.isHidden = true
        
        
        answerOButton.setTitle("O", for: .normal)
        answerOButton.translatesAutoresizingMaskIntoConstraints = false
        answerOButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        answerOButton.setTitleColor(.red, for: .normal)
        answerOButton.backgroundColor = .lightGray
        
        answerXButton.setTitle("X", for: .normal)
        answerXButton.titleLabel?.font = .boldSystemFont(ofSize: 32)
        answerXButton.setTitleColor(.blue, for: .normal)
        answerXButton.backgroundColor = .lightGray
        answerXButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(questionTitleLabel)
        addSubview(answerStackView)
        addSubview(answerOXStackView)
        answerOXStackView.addArrangedSubview(answerOButton)
        answerOXStackView.addArrangedSubview(answerXButton)
    }
    
    func define() {
        NSLayoutConstraint.activate([
            questionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            questionTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            answerStackView.topAnchor.constraint(equalTo: questionTitleLabel.bottomAnchor, constant: 32),
            answerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            answerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            answerOXStackView.topAnchor.constraint(equalTo: questionTitleLabel.bottomAnchor, constant: 32),
            answerOXStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            answerOButton.widthAnchor.constraint(equalToConstant: 100),
            answerOButton.heightAnchor.constraint(equalToConstant: 100),
            answerXButton.widthAnchor.constraint(equalToConstant: 100),
            answerXButton.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
}
