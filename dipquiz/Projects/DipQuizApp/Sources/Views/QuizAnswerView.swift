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
