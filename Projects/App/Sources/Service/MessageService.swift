//
//  MessageService.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import Firebase

struct MessageService: MessageServiceProtocol {
    static let shared: MessageServiceProtocol = MessageService()
    
    func updateMessageStatusIfNecessary(_ messages: [Message]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let lastMessage = messages.last, !lastMessage.read else { return }
        
        try await FirestoreConstants.MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .document(lastMessage.id)
            .updateData(["read": true])
    }
}
