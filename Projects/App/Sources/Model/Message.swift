//
//  Message.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import FirebaseFirestoreSwift
import Firebase
import LinkPresentation

enum MessageSendType {
    case text(String)
    case image(UIImage)
    case link(LinkMetadataWrapper)
}

enum ContentType {
    case text(String)
    case image(String)
    case link(LinkMetadataWrapper)
}

struct Message: Identifiable, Codable, Hashable {
    @DocumentID var messageId: String?
    let fromId: String
    let toId: String
    let caption: String
    let timestamp: Timestamp
    var user: User?
    var read: Bool
    var imageUrl: String?
    
    var id: String {
        return messageId ?? UUID().uuidString
    }
    
    var chatPartnerId: String {
        return fromId == Auth.auth().currentUser?.uid ? toId : fromId
    }
    
    var isFromCurrentUser: Bool {
        return fromId == Auth.auth().currentUser?.uid
    }
    
    var isImageMessage: Bool {
        return imageUrl != nil
    }
    
    var contentType: ContentType {
        if let imageUrl = imageUrl {
            return .image(imageUrl)
        }
        
        if let linkMetaData = linkMetaData {
            return .link(linkMetaData)
        }
        
        return .text(caption)
    }
    
    var linkURLString: String?
    var linkMetaData: LinkMetadataWrapper?
    var linkURL: URL? {
        guard let linkURLString = linkURLString else { return nil }
        return URL(string: linkURLString)
    }
}

// Обертка для LPLinkMetadata
struct LinkMetadataWrapper: Codable, Hashable {
    let title: String?
    let originalURL: URL?
    let imageData: Data?

    init(metadata: LPLinkMetadata, imageData: Data?) {
        self.title = metadata.title
        self.originalURL = metadata.originalURL
        self.imageData = imageData
    }
}

struct Conversation: Identifiable, Hashable, Codable {
    @DocumentID var conversationId: String?
    let lastMessage: Message
    var firstMessageId: String?
    
    var id: String {
        return conversationId ?? UUID().uuidString
    }
}
