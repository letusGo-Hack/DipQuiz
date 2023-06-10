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

import Foundation
import MultipeerConnectivity

class ConnectionManager: NSObject, ObservableObject {
  private static let service = "jobmanager-chat"

  @Published var messages: [Command] = []
  @Published var peers: [MCPeerID] = []
  @Published var connectedToChat = false

  let myPeerId = MCPeerID(displayName: UIDevice.current.name)
  private var advertiserAssistant: MCNearbyServiceAdvertiser?
  private var session: MCSession?
  private var isHosting = false

  func send(_ message: String) {
    let chatMessage = Command(displayName: myPeerId.displayName, body: message)
    messages.append(chatMessage)
    guard
      let session = session,
      let data = message.data(using: .utf8),
      !session.connectedPeers.isEmpty
    else { return }

    do {
      try session.send(data, toPeers: session.connectedPeers, with: .reliable)
    } catch {
      print(error.localizedDescription)
    }
  }

  func sendHistory(to peer: MCPeerID) {
    let tempFile = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("messages.data")
    guard let historyData = try? JSONEncoder().encode(messages) else { return }
    try? historyData.write(to: tempFile)
    session?.sendResource(at: tempFile, withName: "Chat_History", toPeer: peer) { error in
      if let error = error {
        print(error.localizedDescription)
      }
    }
  }

  func join() {
    peers.removeAll()
    messages.removeAll()
    session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
    session?.delegate = self
    guard
      let window = UIApplication.shared.windows.first,
      let session = session
    else { return }

    let mcBrowserViewController = MCBrowserViewController(serviceType: ConnectionManager.service, session: session)
    mcBrowserViewController.delegate = self
    window.rootViewController?.present(mcBrowserViewController, animated: true)
  }

  func host() {
    isHosting = true
    peers.removeAll()
    messages.removeAll()
    connectedToChat = true
    session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
    session?.delegate = self
    advertiserAssistant = MCNearbyServiceAdvertiser(
      peer: myPeerId,
      discoveryInfo: nil,
      serviceType: ConnectionManager.service)
    advertiserAssistant?.delegate = self
    advertiserAssistant?.startAdvertisingPeer()
  }

  func leaveChat() {
    isHosting = false
    connectedToChat = false
    advertiserAssistant?.stopAdvertisingPeer()
    messages.removeAll()
    session = nil
    advertiserAssistant = nil
  }
}

extension ConnectionManager: MCNearbyServiceAdvertiserDelegate {
  func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
    invitationHandler(true, session)
  }
}

extension ConnectionManager: MCSessionDelegate {
  func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
    guard let message = String(data: data, encoding: .utf8) else { return }
    let chatMessage = Command(displayName: peerID.displayName, body: message)
    DispatchQueue.main.async {
      self.messages.append(chatMessage)
    }
  }

  func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
    switch state {
    case .connected:
      if !peers.contains(peerID) {
        DispatchQueue.main.async {
          self.peers.insert(peerID, at: 0)
        }
        if isHosting {
          sendHistory(to: peerID)
        }
      }
    case .notConnected:
      DispatchQueue.main.async {
        if let index = self.peers.firstIndex(of: peerID) {
          self.peers.remove(at: index)
        }
        if self.peers.isEmpty && !self.isHosting {
          self.connectedToChat = false
        }
      }
    case .connecting:
      print("Connecting to: \(peerID.displayName)")
    @unknown default:
      print("Unknown state: \(state)")
    }
  }

  func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}

  func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
    print("Receiving chat history")
  }

  func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
    guard
      let localURL = localURL,
      let data = try? Data(contentsOf: localURL),
      let messages = try? JSONDecoder().decode([Command].self, from: data)
    else { return }

    DispatchQueue.main.async {
      self.messages.insert(contentsOf: messages, at: 0)
    }
  }
}

extension ConnectionManager: MCBrowserViewControllerDelegate {
  func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
    browserViewController.dismiss(animated: true) {
      self.connectedToChat = true
    }
  }

  func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
    session?.disconnect()
    browserViewController.dismiss(animated: true)
  }
}
