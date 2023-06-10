//
//  QuizAnswerView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI

struct QuizAnswerView: View {
    var answer: String
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Text(answer)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(24)
                    
            }
        }
        
    }
}

#Preview {
    QuizAnswerView(answer: "테스트")
}
