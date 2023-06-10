//
//  QuestionType.swift
//  DQCommon
//
//  Created by 고병학 on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import Foundation

public enum QuestionType: Int, CaseIterable {
    case TYPE_SELECT
    case TYPE_OX
    
    public var stringValue: String {
        switch self {
        case .TYPE_SELECT: return "객관식"
        case .TYPE_OX: return "O / X"
        }
    }
}
