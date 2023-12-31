import Foundation
import MultipeerConnectivity


public class ConnectionManager: NSObject, ObservableObject {
    
    private static let service = "jobmanager-chat"
    
    @Published public var messages: [Command] = []
    @Published public var peers: [MCPeerID] = []
    @Published public var connectedToChat = false
    @Published public var onFinsh = false
    
    public var myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private var advertiserAssistant: MCNearbyServiceAdvertiser?
    private var session: MCSession?
    private var isHosting = false
        
    //싱클톡 추가.
    public static let shared = ConnectionManager()
    private override init() {
        super.init()
    }
    public var sharedInstance: ConnectionManager {
        return ConnectionManager.shared
    }
    
    public func displayname(_ name: String){
        myPeerId = MCPeerID(displayName: name)
    }
    
    //클라이언트 -> 호스트 처음 초기화전송
    public func sendInit(questID: String){
        send(_question_id: questID, _question: "", _answer: "", _value: "", _type: .INT)
    }
    
    //host -> 클라이언트에게 문제를 한개씩 보냄(10)
    public func send(_question_id: String,
                     _question: String,
                     _answer: String,
                     _value: String,
                     _type: CommandType)
    {
        let chatMessage = Command(displayName: myPeerId.displayName, body: "", question_id: _question_id, question: _question, answer: _answer, value: _value, type:_type)
        messages.append(chatMessage)
        guard
            let session = session,
            let data: Data = try? JSONEncoder().encode(chatMessage),
//            let data = newData(using: .utf8),
                
            !session.connectedPeers.isEmpty
        else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func sendHistory(to peer: MCPeerID) {
        let tempFile = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("messages.data")
        guard let historyData = try? JSONEncoder().encode(messages) else { return }
        try? historyData.write(to: tempFile)
        session?.sendResource(at: tempFile, withName: "Chat_History", toPeer: peer) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    public func join() {
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
    
    public func host() {
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
    
    public func leaveChat() {
        isHosting = false
        connectedToChat = false
        advertiserAssistant?.stopAdvertisingPeer()
        messages.removeAll()
        session = nil
        advertiserAssistant = nil
    }
}

extension ConnectionManager: MCNearbyServiceAdvertiserDelegate {
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
}

extension ConnectionManager: MCSessionDelegate {
    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let chatMessage: Command = try? JSONDecoder().decode(Command.self, from: data) else { return }
        DispatchQueue.main.async {
            self.messages.append(chatMessage)
        }
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
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
    
    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {}
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("Receiving chat history")
    }
    
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
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
    public func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        browserViewController.dismiss(animated: true) {
            self.connectedToChat = true
            self.onFinsh = true
        }
    }
    
    public func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        session?.disconnect()
        browserViewController.dismiss(animated: true)
//        delegate?.ConnectDidFinish(-1)
    }
}
