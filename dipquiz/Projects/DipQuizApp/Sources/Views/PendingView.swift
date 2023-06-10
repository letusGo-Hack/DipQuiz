//
//  PendingView.swift
//  dipquiz
//
//  Created by Ever on 2023/06/10.
//

import SwiftUI

struct PendingView: View {
    var body: some View {
        HStack {
            Rectangle().foregroundColor(Color.red)
                .frame(width: 100, height: 100)
            Rectangle().foregroundColor(Color.red)
                .frame(width: 100, height: 100)
            Rectangle().foregroundColor(Color.red)
                .frame(width: 100, height: 100)
        }
    }
}
