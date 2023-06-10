//
//  HomeViewController.swift
//  DipQuizClientApp
//
//  Created by Derrick kim on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit
import DQCommon
import Combine

final class HomeViewController: UIViewController {
    private let manager = UserDefaultsManager.shared
    private var connectionManager = ConnectionManager.shared

    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nickNameLabel,
                                                       joinButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()

    private let nickNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let joinButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("가입", for: .normal)
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if connectionManager.onFinsh {
            print("")
        }
    }

    func setupDefault() {
        view.addSubview(textStackView)

        configureLayouts()
        setupButton()
        bindViewModel()

        nickNameLabel.text = "\(manager.loadText())님 반갑습니다."
    }

    func configureLayouts() {
        NSLayoutConstraint.activate([
            textStackView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textStackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }

    private func setupButton() {
        joinButton.addTarget(self, action: #selector(didTapJoinButton), for: .touchUpInside)
    }

    private func bindViewModel() {

    }

    @objc private func didTapJoinButton(_ sender: UIButton) {
        connectionManager.join()
    }
}
