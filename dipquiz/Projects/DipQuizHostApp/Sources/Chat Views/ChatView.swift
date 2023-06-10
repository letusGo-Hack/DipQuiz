/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI
import DQCommon

struct ChatView: View {
  @EnvironmentObject var chatConnectionManager: ConnectionManager
  @State private var messageText = ""

  var body: some View {
    VStack {
      chatInfoView
      ChatListView()
        .environmentObject(chatConnectionManager)
      messageField
    }
    .navigationBarTitle("Chat", displayMode: .inline)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button("Leave") {
          chatConnectionManager.leaveChat()
        }
      }
    }
    .navigationBarBackButtonHidden(true)
  }

  private var messageField: some View {
    VStack(spacing: 0) {
      Divider()
      // swiftlint:disable:next trailing_closure
      TextField("Enter Message", text: $messageText, onCommit: {
        guard !messageText.isEmpty else { return }
//        chatConnectionManager.send(messageText)
        messageText = ""
      })
      .padding()
    }
  }

  private var chatInfoView: some View {
    VStack(alignment: .leading) {
      Divider()
      HStack {
        Text("People in chat:")
          .fixedSize(horizontal: true, vertical: false)
          .font(.headline)
        if chatConnectionManager.peers.isEmpty {
          Text("Empty")
            .font(Font.caption.italic())
            .foregroundColor(Color("rw-dark"))
        } else {
          chatParticipants
        }
      }
      .padding(.top, 8)
      .padding(.leading, 16)
      Divider()
    }
    .frame(height: 44)
  }

  private var chatParticipants: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack {
        ForEach(chatConnectionManager.peers, id: \.self) { peer in
          Text(peer.displayName)
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 6)
            .background(Color("rw-dark"))
            .foregroundColor(.white)
            .font(Font.body.bold())
            .cornerRadius(9)
        }
      }
    }
  }
}

#if DEBUG
import MultipeerConnectivity
struct ChatView_Previews: PreviewProvider {
    static let chatConnectionManager = ConnectionManager.shared

  static var previews: some View {
    NavigationView {
      ChatView()
        .environmentObject(chatConnectionManager)
        .onAppear {
          chatConnectionManager.peers.append(MCPeerID(displayName: "Test Peer"))
        }
    }
  }
}
#endif
