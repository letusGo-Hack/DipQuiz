//
//  HomeView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Spacer()
            joinButton
                .frame(height: 64)
                .padding(.horizontal, 40)
            Spacer()
        }
        .background(Color.white)
    }
    
    private var joinButton: some View {
        Button(action: joinButtonTapped) {
            Text("Join")
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.yellow)
                .cornerRadius(8)
        }
    }
    
    private func joinButtonTapped() {
        print("Join Button Tapped")
    }
}
