//
//  ManagingView.swift
//  host
//
//  Created by 고병학 on 2023/06/10.
//

import SwiftUI

struct ManagingView: View {
    @State private var selectedSegment: Int = 0
    private let segmentItems: [String] = ["객관식", "주관식", "O X"]
    private var items: [String] = Array(repeating: "", count: 30)
    
    var body: some View {
        VStack {
            Spacer().frame(height: 0)
            Picker(
                selection: $selectedSegment,
                label: Text("Segmented Control")
            ) {
                ForEach(0..<3) { index in
                    Text(segmentItems[index])
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            Spacer()
            List(items, id: \.self) { item in
                QuizCardView()
            }
        }
        .navigationTitle("관리")
    }
}

#Preview {
    ManagingView()
}
