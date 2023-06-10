//
//  QuizView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var appState: AppState
    @State private var question: String = "[문제] 여기에 문제에 대한 텍스트가 표시됩니다."
    @State private var answers: [String] = [
        "문제 답변 1",
        "문제 답변 2",
        "문제 답변 3",
        "문제 답변 4",
        "문제 답변 5",
    ]
    
    var body: some View {
        VStack {
            Text(question)
                .font(.system(size: 18))
                .padding()
            
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(answers, id: \.self) { answer in
                        QuizAnswerView(answer: answer)
                    }
                }
                .padding(.horizontal, 32)
            }
        }
        
    }
    
    func configure(question: String, answers: [String]) -> Self {
        self.question = question
        self.answers = answers
        return self
    }
}

#Preview {
    QuizView()
}
