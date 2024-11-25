//
//  MockMessage.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

public struct MockMessage {
    var messageId: String
    var fromId: String
    var toId: String
    var caption: String
    var timestamp: String
    var user: MockUser
    var read: Bool
    var imageUrl: String?
    
    public var isFromCurrentUser: Bool {
        return fromId == user.userId
    }
}

public class DeveloperPreview {
    static let shared = DeveloperPreview()

    // Моковый пользователь
    public var user: MockUser {
        MockUser(
            userId: "12345",
            username: "benjiloya",
            fullname: "Benji Loya",
            email: "batman@gmail.com",
            profileImageUrl: nil,
            bio: "Just a superhero in disguise.",
            link: "https://batman.com"
        )
    }
    
    // Массив моковых сообщений
    public var messages: [MockMessage] {
        [
            MockMessage(
                messageId: "1",
                fromId: "12345",
                toId: "67890",
                caption: "Hello! This is a test message.",
                timestamp: "2024-11-25T10:00:00Z",
                user: user,
                read: false,
                imageUrl: "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
            ),
            MockMessage(
                messageId: "2",
                fromId: "67890",
                toId: "12345",
                caption: "Hi! Here's another test message.\nstring test message.",
                timestamp: "2024-11-25T10:10:00Z",
                user: user,
                read: true,
                imageUrl: nil
            )
        ]
    }
}
