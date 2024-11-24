//
//  ResentChatView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.11.2024.
//

import SwiftUI

struct RecentChatsView: View {
    @ObservedObject var viewModel: InboxViewModel
    var onChatTapped: ((User) -> Void)?

    var body: some View {
        LazyVStack {
                Text("Recent Chat")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary.opacity(0.85))
                    .padding(.vertical, 5)
                    .padding(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer(minLength: 0)
                
                if !viewModel.didCompleteInitialLoad {
                    ForEach(0..<10) { _ in
                        placeholderRecentChats()
                    }
                } else {
                    ForEach(viewModel.filteredMessages) { recentMessage in
                        if let user = recentMessage.user {
                            RecentChatCell(
                                message: recentMessage,
                                profileImage: CircularProfileImageView(user: user, size: .medium50),
                                username: user.username,
                                timestamp: recentMessage.timestamp.timestampString(),
                                textMessage: recentMessage.caption,
                                actionButtonTapped: {
                                    Task { try await viewModel.deleteMessage(recentMessage) }
                                },
                                showChatTapped: {
                                    onChatTapped?(user)
                                }
                            )
                            .padding(.horizontal, 10)
                            .onAppear {
                                if recentMessage == viewModel.recentMessages.last {
                                    print("DEBUG: Paginate here..")
                                }
                            }
                        }
                    }
                
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    RecentChatsView(viewModel: .mock)
}
