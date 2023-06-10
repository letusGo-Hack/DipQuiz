//
//  QuizView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var appState: AppState
    @State private var question: String = "문제"
    @State private var answers: [String] = []
    
    
    var body: some View {
        VStack {
            Text(question)
                .font(.system(size: 18))
                .padding()
            
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(answers, id: \.self) { answer in
                        QuizAnswerView(answer: answer)
                    }
                }
                .padding(.horizontal, 32)
            }
        }
    }
    
    func configure(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
}
