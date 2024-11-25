//
//  PostHeaderView.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

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


struct RecentChatCell_Previews: PreviewProvider {
    static var previews: some View {
       //  Моковые данные сообщения
        let message = MockMessage(
            messageId: "1",
            fromId: "12345",
            toId: "67890",
            caption: "Hello! This is a test message.",
            timestamp: "2024-11-25T10:00:00Z",
            user: DeveloperPreview.shared.user,
            read: false,
            imageUrl: "https://i.pinimg.com/originals/63/f0/17/63f017a7b9ad24d609b404515d86f9f4.jpg"
        )

       //  Моковые данные для отображения изображения профиля
        let profileImageView = CircularProfileImageView(profile: DeveloperPreview.shared.user as! ProfileRepresentable, size: .medium50)

        // Возвращаем превью
        return VStack {
            RecentChatCell(
                message: message,
                profileImage: profileImageView,
                username: message.user.username,
                timestamp: message.timestamp,
                textMessage: message.caption
            )
        }
        .padding(.horizontal)
        .previewLayout(.sizeThatFits)
    }
}

