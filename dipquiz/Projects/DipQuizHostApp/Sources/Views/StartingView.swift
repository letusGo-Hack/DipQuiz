//
//  StartingView.swift
//  host
//
//  Created by 고병학 on 2023/06/10.
//

import SwiftUI
import DQCommon

struct StartingView: View {
    @EnvironmentObject var modelData: ConnectionManager
    
    var body: some View {
        //        Text("시작 페이지입니다.")
        //            .navigationTitle("시작")
        //
        ScrollView {
            ScrollViewReader { reader in
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(modelData.messages) { message in
                        MessageBodyView(message: message)
                            .onAppear {
                                if message == modelData.messages.last {
                                    reader.scrollTo(message.id)
                                }
                            }
                    }
                }
                .padding(16)
            }
        }
        .background(Color(UIColor.systemBackground))
    }
}




struct MessageBodyView: View {
  let message: Command

  var body: some View {
    HStack {
      if message.isUser {
        Spacer()
      }
      VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
          Text(message.question)
          .font(.body)
          .padding(8)
          .foregroundColor(.white)
          .background(message.isUser ? .green : Color("rw-dark"))
          .cornerRadius(9)
          TimestampView(message: message)
      }
    }
  }
}

struct TimestampView: View {
  let message: Command

  var body: some View {
    HStack(spacing: 2) {
      Text(message.question)
      Text("@")
//      Text("\(, formatter: DateFormatter.timestampFormatter)")
      if !message.isUser {
        Spacer()
      }
    }
    .font(.caption)
    .foregroundColor(Color("rw-dark"))
  }
}

