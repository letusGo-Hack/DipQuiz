//
//  HomeView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI
import DQCommon

struct HomeView: View {
    @EnvironmentObject var modelData: ConnectionManager
    
    var body: some View {
        VStack {
            Spacer()
            joinButton
                .frame(height: 64)
                .padding(.horizontal, 40)
            Spacer()
        }.onAppear(){
            ConnectionManager.shared.displayname("c1")//클라이언트 이름

        }
        .background(Color.white)
        .onAppear {
            if modelData.onFinsh {
                print("")
            }
        }
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
        ConnectionManager.shared.join()
    }
}
