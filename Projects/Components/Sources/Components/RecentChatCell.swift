//
//  PostHeaderView.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

/*
import SwiftUI
import SwiftfulUI

public struct RecentChatCell<ProfileImageView: View>: View {
    public var message: MockMessage
    public let profileImage: ProfileImageView
    public let username: String
    public let timestamp: String
    public let textMessage: String?
    public var actionButtonTapped: (() -> Void)? = nil
    public var showChatTapped: (() -> Void)? = nil
    public var profileImageTapped: (() -> Void)? = nil
    
    public init(
            message: MockMessage,
            profileImage: ProfileImageView,
            username: String,
            timestamp: String,
            textMessage: String?,
            actionButtonTapped: (() -> Void)? = nil,
            showChatTapped: (() -> Void)? = nil,
            profileImageTapped: (() -> Void)? = nil
        ) {
            self.message = message
            self.profileImage = profileImage
            self.username = username
            self.timestamp = timestamp
            self.textMessage = textMessage
            self.actionButtonTapped = actionButtonTapped
            self.showChatTapped = showChatTapped
            self.profileImageTapped = profileImageTapped
        }
    
    public var body: some View {
        HStack(spacing: 10) {
            // Отображение изображения
            profileImage
                .asButton(.press) {
                    profileImageTapped?()
                }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .center, spacing: 10) {
                    // имя юзера
                        Text(username)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                    
                    // Дата
                    Text(timestamp)
                        .textScale(.secondary)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary.opacity(0.7))
                    
                    // прочнено - или нет
                    if !message.read && !message.isFromCurrentUser {
                        Circle()
                            .fill(Color.blue)
                            .frame(width: 6, height: 6)
                    }
                    
                    Spacer(minLength: 0)
                    
                    Image(systemName: "ellipsis")
                        .foregroundStyle(.gray)
                        .padding(15)
                        .background(Color.black.opacity(0.001))
                        .clipShape(Circle())
                        .asButton(.press) {
                            actionButtonTapped?()
                        }
                }
                
                Rectangle()
                    .frame(width: 250, height:38)
                    .foregroundStyle(.black.opacity(0.001))
                    .overlay {
                        // Текст сообщения
                        VStack (spacing: 2) {
                            if let textMessage = textMessage {
                                Text("\(message.isFromCurrentUser ? "You: \(textMessage)" : textMessage)")
                            }
                            
                            Spacer(minLength: 0)
                        }
                        .font(.footnote)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.red.opacity(0.001))
                        .asButton(.opacity) {
                             showChatTapped?()
                        }
                    }
                
                Divider()
                    .opacity(0.5)
                    .offset(y: 10)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 5)
        }
        .padding(.top, 8)
        
    }
}

#Preview {
    // Массив моковых сообщений
    let messages = [
        MockMessage.createMockTextMessage(),
        MockMessage.createMockLinkMessage()
    ]
    
    // Используем ForEach для отображения всех сообщений
    VStack(spacing: 20) {
        ForEach(messages, id: \.messageId) { message in
            RecentChatCell(
                message: message,
                profileImage: Image(systemName: "person.circle.fill")
                    .resizable()
                    .scaledToFill()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(width: 40, height: 40),
                username: "User \(message.fromId)",
                timestamp: "2m ago",
                textMessage: message.caption
            )
        }
    }
    .padding()
}
*/
