//
//  QuestionModel.swift
//  DQCommon
//
//  Created by 고병학 on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import Foundation
import SwiftData

@Model
public class QuestionModel {
    public var value: CodableQuestionModel

    public init(value: CodableQuestionModel) {
        self.value = value
    }
}

public struct CodableQuestionModel: Codable, Hashable {
    public var index: Int
    public var question_id: String
    public var question: String
    public var question_choices: String
    public var answer: String
    public var response: Bool
    public var question_type: Int
    
    public init(
        index: Int,
        question_id: String,
        question: String,
        question_choices: String,
        answer: String,
        response: Bool,
        question_type: Int
    ) {
        self.index = index
        self.question_id = question_id
        self.question = question
        self.question_choices = question_choices
        self.answer = answer
        self.response = response
        self.question_type = question_type
    }
}
