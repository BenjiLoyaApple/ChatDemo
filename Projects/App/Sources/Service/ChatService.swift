//
//  ChatService.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import Foundation
import Firebase

class ChatService: ChatServiceProtocol {
    
    let chatPartner: User
    private let fetchLimit = 50
    private var firestoreListener: ListenerRegistration?
    
    init(chatPartner: User) {
        self.chatPartner = chatPartner
    }
    
    func observeMessages(completion: @escaping([Message]) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let query = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection(chatPartnerId)
            .limit(toLast: fetchLimit)
            .order(by: "timestamp", descending: false)
        
        self.firestoreListener = query.addSnapshotListener { [weak self] snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            var messages = changes.compactMap{ try? $0.document.data(as: Message.self) }
            
            for (index, message) in messages.enumerated() where message.fromId != currentUid {
                messages[index].user = self?.chatPartner
            }
            
            completion(messages)
        }
    }
    
    func sendMessage(type: MessageSendType) async throws {
        switch type {
        case .text(let messageText):
            uploadMessage(messageText)
        case .image(let uIImage):
            let imageUrl = try await ImageUploader.uploadImage(image: uIImage, type: .message)
            uploadMessage("Image", imageUrl: imageUrl)
        case .link(let linkMetadata):
                 let encodedLinkMetadata = try? JSONEncoder().encode(linkMetadata)
                 let encodedLinkMetadataString = encodedLinkMetadata?.base64EncodedString()
                 uploadMessage(linkMetadata.title ?? "Link", linkMetadata: encodedLinkMetadataString)
        }
    }
    
    private func uploadMessage(_ messageText: String, imageUrl: String? = nil, linkMetadata: String? = nil) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        let chatPartnerId = chatPartner.id
        
        let currentUserRef = FirestoreConstants.MessagesCollection.document(currentUid).collection(chatPartnerId).document()
        let chatPartnerRef = FirestoreConstants.MessagesCollection.document(chatPartnerId).collection(currentUid)
        
        let recentCurrentUserRef = FirestoreConstants.MessagesCollection
            .document(currentUid)
            .collection("recent-messages")
            .document(chatPartnerId)
        
        let recentPartnerRef = FirestoreConstants.MessagesCollection
            .document(chatPartnerId)
            .collection("recent-messages")
            .document(currentUid)
        
        let messageId = currentUserRef.documentID
        let message = Message(
            messageId: messageId,
            fromId: currentUid,
            toId: chatPartnerId,
            caption: messageText,
            timestamp: Timestamp(),
            read: false,
            imageUrl: imageUrl,
            linkMetaData: linkMetadata != nil ? try? JSONDecoder().decode(LinkMetadataWrapper.self, from: Data(base64Encoded: linkMetadata!)!) : nil
                 
        )
        var currentUserMessage = message
        currentUserMessage.read = true
        
        guard let encodedMessage = try? Firestore.Encoder().encode(message) else { return }
        guard let encodedMessageCopy = try? Firestore.Encoder().encode(currentUserMessage) else { return }
        
        currentUserRef.setData(encodedMessageCopy)
        chatPartnerRef.document(messageId).setData(encodedMessage)
        
        recentCurrentUserRef.setData(encodedMessageCopy)
        recentPartnerRef.setData(encodedMessage)
    }
    
    func updateMessageStatusIfNecessary(_ message: Message) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard !message.read else { return }
                
        try await FirestoreConstants.MessagesCollection
            .document(uid)
            .collection("recent-messages")
            .document(message.chatPartnerId)
            .updateData(["read": true])
    }
    
    func removeListener() {
        self.firestoreListener?.remove()
        self.firestoreListener = nil
    }
}
