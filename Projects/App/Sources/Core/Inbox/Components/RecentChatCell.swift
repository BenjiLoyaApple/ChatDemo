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
    var actionButtonTapped: (() -> Void)? = nil
    var showChatTapped: (() -> Void)? = nil
    var profileImageTapped: (() -> Void)? = nil
    
    var body: some View {
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
                    
                    /// Chat Options
                    Menu {
                        ControlGroup {
                            Button {
                                print("Uno tapped")
                            } label: {
                                Label {
                                    Text("📌 \nPin")
                                } icon: {
                                    EmptyView() // Не используем иконку, только текст
                                }
                            }
                            
                            Button {
                                print("Uno tapped")
                            } label: {
                                Label {
                                    Text("📮 \nShare")
                                } icon: {
                                    EmptyView() // Не используем иконку, только текст
                                }
                            }
                            
//                            Button {
//                                print("Share")
//                            } label: {
//                                Label("Share", systemImage: "square.and.arrow.up")
//                            }
                            
                            Menu {
                                Button(role: .destructive) {
                                    actionButtonTapped?()
                                        } label: {
                                            Label("For me", systemImage: "")
                                        }
                                
                                Button("For me & \(username)") {
                                    // Ваши действия здесь
                                }
                                
                            } label: {
                                Label {
                                    Text("🗑️ \nDelete")
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                } icon: {
                                    EmptyView() // Не используем иконку, только текст
                                }
                            }
                        }
                     //   Button("Two") {
                            
                      //  }
//                        Menu("Delete Chat") {
//                            Button(role: .destructive) {
//                                actionButtonTapped?()
//                                    } label: {
//                                        Label("For me", systemImage: "")
//                                    }
//                            
//                            Button("For me & \(username)") {
//                                // Ваши действия здесь
//                            }
//                            
//                        }
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

