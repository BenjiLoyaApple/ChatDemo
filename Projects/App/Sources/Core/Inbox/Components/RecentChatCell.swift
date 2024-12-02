//
//  PostHeaderView.swift
//  ChatApp
//
//  Created by Benji Loya on 01.09.2024.
//

import SwiftUI
import SwiftfulUI
import Components

struct RecentChatCell<ProfileImageView: View>: View {
    var message: Message
    let profileImage: ProfileImageView
    let username: String
    let timestamp: String
    let textMessage: String?
    var showChatTapped: (() -> Void)? = nil
    var profileImageTapped: (() -> Void)? = nil
    
    // Menu Properties
    var pinButtonTapped: (() -> Void)? = nil
    var shareButtonTapped: (() -> Void)? = nil
    var deleteForMeButtonTapped: (() -> Void)? = nil
    var deleteAllButtonTapped: (() -> Void)? = nil
    var clearButtonTapped: (() -> Void)? = nil
    var notificationButtonTapped: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 10) {
            //MARK: - Profile image
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
                    Text(message.timestamp.timestampString())
                        .textScale(.secondary)
                        .fontWeight(.light)
                        .foregroundStyle(.secondary.opacity(0.7))
                    
                    // прочнено - или нет
                    if !message.read && !message.isFromCurrentUser {
                        Circle()
                            .fill(Color.theme.primaryBlue)
                            .frame(width: 6, height: 6)
                    }
                    
                    Spacer(minLength: 0)
                    
                    //MARK: - Chat Options
                    Menu {
                        /// Pin
                        ControlGroup {
                            Button {
                                pinButtonTapped?()
                            } label: {
                                Image(systemName: "pin")
                                Text("Pin")
                            }
                            
                            /// Share
                            Button {
                                shareButtonTapped?()
                            } label: {
                                Image(systemName: "square.and.arrow.up")
                                Text("Share")
                            }
                            
                            /// Delete
                            Menu {
                                /// For Me
                                Button(role: .destructive) {
                                    deleteForMeButtonTapped?()
                                } label: {
                                    Label("For me", systemImage: "person")
                                }
                                
                                /// For All Users
                                Button {
                                    deleteAllButtonTapped?()
                                } label: {
                                    Image(systemName: "person.2")
                                    Text("For me & \(username)")
                                }
                                
                            } label: {
                                Image(systemName: "arrow.up.trash")
                                Text("Delete")
                            }
                            
                        }
                        
                        /// Clear Chat
                        Button {
                            clearButtonTapped?()
                        } label: {
                            Text("Clear chat")
                            Image(systemName: "eraser.line.dashed")
                            
                        }
                        
                        /// Notifications
                        Button {
                            notificationButtonTapped?()
                        } label: {
                            Text("Notifications")
                            Image(systemName: "bell")
                        }
                        
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .foregroundStyle(.gray)
                            .padding(15)
                            .background(Color.black.opacity(0.001))
                            .clipShape(Circle())
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

struct InboxCell_Previews: PreviewProvider {
    static var previews: some View {
        let messages = DeveloperPreview.shared.messages
        let user = DeveloperPreview.shared.user
        let profileImageView = CircularProfileImageView(user: user, size: .medium50)
        
        return VStack {
            ForEach(messages.indices, id: \.self) { index in
                RecentChatCell(
                    message: messages[index],
                    profileImage: profileImageView,
                    username: user.username,
                    timestamp: "1h ago",
                    textMessage: messages[index].caption
                )
            }
        }
        .padding(.horizontal)
        .previewLayout(.sizeThatFits)
    }
}

