//
//  ConnectionManagerWrapper.swift
//  DQCommon
//
//  Created by Ever on 2023/06/10.
//  Copyright © 2023 kr.byunghak. All rights reserved.
//

import Foundation
import Combine

public enum ConnectionManagerWrapperEvent {
    case messagesChanged([Command])
    case peersCountChanged(Int)
    case connectedToChatChanged(Bool)
    case onFinishChanged(Bool)
}

public protocol ConnectionManagerWrapperListener: AnyObject {
    func event(_ event: ConnectionManagerWrapperEvent)
}

public final class ConnectionManagerWrapper {
    private let manager = ConnectionManager.shared
    private var messages: [Command] = []
    private var peersCount: Int = 0
    private var connectedToChat = false
    private var onFinsh = false
    
    private var bag = Set<AnyCancellable>()
    public init() {
        manager.objectWillChange.sink { [weak self] in
            self?.render()
        }.store(in: &bag)
    }
    
    public weak var listener: ConnectionManagerWrapperListener?
        
    private func render() {
        if messages != manager.messages {
            messages = manager.messages
            listener?.event(.messagesChanged(messages))
        }
        
        if peersCount != manager.messages.count {
            peersCount = manager.messages.count
            listener?.event(.peersCountChanged(peersCount))
        }
        if connectedToChat != manager.connectedToChat {
            connectedToChat = manager.connectedToChat
            listener?.event(.connectedToChatChanged(connectedToChat))
        }
        if onFinsh != manager.onFinsh {
            onFinsh = manager.onFinsh
            listener?.event(.onFinishChanged(onFinsh))
        }
    }
}
