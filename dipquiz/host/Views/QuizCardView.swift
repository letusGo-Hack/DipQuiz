//
//  QuizCardView.swift
//  host
//
//  Created by 고병학 on 2023/06/10.
//

import SwiftUI

struct QuizCardView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("카드 뷰")
                .font(.title2)
                .fontWeight(.bold)
            
            Spacer().frame(height: 10)
            
            Text("문제")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Swift 5.9에서 제네릭 시스템이 어떻게 개선되었습니까?")
            
            Spacer().frame(height: 10)
            
            Text("정답")
                .font(.title3)
                .fontWeight(.semibold)
            Text("이제 인수 길이에 대한 추상화를 지원합니다.")
        }
    }
}

#Preview {
    QuizCardView()
        .frame(width: 300)
}
