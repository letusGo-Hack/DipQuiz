//
//  JoinViewController.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//

import UIKit

final class JoinViewController: UIViewController {
    private let manager = UserDefaultsManager.shared

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [textFieldView,
                                                       warningLabel,
                                                       createNickNameButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private let textFieldView: UITextField = {
        let textView = UITextField()
        textView.placeholder = " 닉네임을 입력해주세요"
        textView.layer.cornerRadius = 10
        textView.layer.borderColor = UIColor.gray.cgColor
        textView.layer.borderWidth = 1
        textView.translatesAutoresizingMaskIntoConstraints = false

        return textView
    }()

    private let warningLabel: UILabel = {
        let label = UILabel()
        label.text = "한 글자이상 입력해주세요."
        label.textColor = .red
        label.isHidden = true
        return label
    }()

    private let createNickNameButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("생성", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.textColor = .red
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupDefault()
    }

    func setupDefault() {
        view.addSubview(textStackView)

        configureLayouts()
        setupButton()
    }

    func configureLayouts() {
        NSLayoutConstraint.activate([
            textStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 50),
            textFieldView.widthAnchor.constraint(equalToConstant: 300)
        ])
    }

    private func setupButton() {
        createNickNameButton.addTarget(self, action: #selector(didTapJoinButton), for: .touchUpInside)
    }

    @objc private func didTapJoinButton(_ sender: UIButton) {
        if textFieldView.text?.isEmpty == true {
            warningLabel.isHidden = false
        } else {
            guard let text = textFieldView.text else {
                return
            }
            
            manager.saveText(text)
            
            let homeViewController = HomeViewController()
            navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
}

