//
//  PendingView.swift
//  DipQuizClientApp
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import UIKit

enum PendingViewAction {
    
}

protocol PendingViewListener: AnyObject {
    func action(_ action: PendingViewAction)
}

final class PendingView: UIView {
    init() {
        super.init(frame: .zero)
        setupViews()
        define()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var listener: PendingViewListener?
    
    private let descriptionLabel = UILabel()
}

private extension PendingView {
    func setupViews() {
        backgroundColor = .white
        addSubview(descriptionLabel)
        descriptionLabel.text = "현재 다른 참여자를 기다리는 중입니다."
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func define() {
        NSLayoutConstraint.activate([
            descriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
