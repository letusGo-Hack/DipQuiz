//
//  UserDefaultsManager.swift
//  DipQuiz
//
//  Created by Derrick kim on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()

    private let defaults = UserDefaults.standard

    func saveText(_ text: String) {
        defaults.set(text, forKey: "nickName")
    }

    func loadText() -> String {
        return defaults.string(forKey: "nickName") ?? ""
    }
}
