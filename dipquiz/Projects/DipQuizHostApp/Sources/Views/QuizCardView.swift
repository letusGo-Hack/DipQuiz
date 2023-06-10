//
//  QuizCardView.swift
//  host
//
//  Created by 고병학 on 2023/06/10.
//

import SwiftUI

struct QuizCardView: View {
    let question: String
    let answer: String
    
    init(question: String, answer: String) {
        self.question = question
        self.answer = answer
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question)
                .font(.headline)
                .fontWeight(.semibold)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            
            Text("정답: \(answer)")
                .font(.subheadline)
                .foregroundStyle(Color.accentColor)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    QuizCardView(
        question: "Swift 5.9에서 제네릭 시스템이 어떻게 개선되었습니까?",
        answer: "이제 인수 길이에 대한 추상화를 지원합니다."
    )
    .frame(width: 300)
}
