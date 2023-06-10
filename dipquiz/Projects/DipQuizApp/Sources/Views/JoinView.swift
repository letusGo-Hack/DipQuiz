//
//  JoinView.swift
//  DipQuiz
//
//  Created by Derrick kim on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import SwiftUI
import UIKit

struct JoinView: View {
    @EnvironmentObject var appState: AppState
    @State private var nickName: String = ""

    var body: some View {
        VStack(alignment: .center) {
            Spacer()

            VStack {
                TextField(
                    "닉네임을 입력해주세요",
                    text: $nickName)
                .background(Color.gray)
                .disableAutocorrection(true)
                .padding()
                .onDisappear {
                    UserDefaultsManager.shared.saveText(nickName)
                }

                Text("한 글자이상 입력해주세요.")
                    .font(.caption2)
                    .foregroundColor(!nickName.isEmpty ? .clear : .red)
            }

            Spacer()

            NavigationLink("생성") {
                HomeView()
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

#Preview {
    JoinView()
}
