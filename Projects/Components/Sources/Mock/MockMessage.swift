//
//  MockMessage.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//


import Foundation
import LinkPresentation

public struct MockMessage: MessageRepresentable {
    public var messageId: String
    public var fromId: String
    public var toId: String
    public var caption: String
    public var timestamp: Date
    public var imageUrl: String?
    public var read: Bool
    public var contentType: ContentType
    
    // Добавляем isFromCurrentUser для проверки текущего пользователя
    public var isFromCurrentUser: Bool {
        return fromId == "currentUserId" // Замените на ID текущего пользователя
    }

    // Инициализатор для MockMessage
    public init(messageId: String = UUID().uuidString, fromId: String, toId: String, caption: String, timestamp: Date, imageUrl: String? = nil, read: Bool = false, contentType: ContentType = .text("Sample text")) {
        self.messageId = messageId
        self.fromId = fromId
        self.toId = toId
        self.caption = caption
        self.timestamp = timestamp
        self.imageUrl = imageUrl
        self.read = read
        self.contentType = contentType
    }
    
    // Функции для создания моковых сообщений
    public static func createMockTextMessage() -> MockMessage {
        return MockMessage(
            messageId: "mockMessage1",
            fromId: "1",
            toId: "2",
            caption: "This is a mock text message",
            timestamp: Date(),
            imageUrl: nil,
            read: true,
            contentType: .text("This is a mock text message")
        )
    }
    
    public static func createMockImageMessage() -> MockMessage {
        return MockMessage(
            messageId: "mockMessage2",
            fromId: "2",
            toId: "2",
            caption: "",
            timestamp: Date(),
            imageUrl: "https://example.com/image.jpg",
            read: true,
            contentType: .image("https://example.com/image.jpg")
        )
    }
    
    public static func createMockLinkMessage() -> MockMessage {
        let linkMetaData = LinkMetadataWrapper(metadata: LPLinkMetadata(), imageData: nil)
        return MockMessage(
            messageId: "mockMessage3",
            fromId: "3",
            toId: "2",
            caption: "Check this out!",
            timestamp: Date(),
            imageUrl: nil,
            read: false,
            contentType: .link(linkMetaData)
        )
    }
}
