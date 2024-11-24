//
//  InboxView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct InboxView: View {
    @Environment(\.router) var router
    
    @StateObject var vmActiveNow = ActiveNowViewModel()
    @StateObject var vmInbox = InboxViewModel()
    @State private var selectedUser: User?
    
    @State private var showChat = false
    @State private var showProfile = false
    
    // MARK: View Properties
    @State private var headerHeight: CGFloat = 0
    @State private var headerOffset: CGFloat = 0
    @State private var lastHeaderOffset: CGFloat = 0
    @State private var direction: SwipeDirection = .none
    /// MARK: Shift Offset Means The Value From Where It Shifted From Up/Down
    @State private var shiftOffset: CGFloat = 0
    
    @State private var isAuthenticated = false
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.clear)
                .frame(width: 200, height: 1)
                .padding(.top, headerHeight)
                .offsetY { previous, current in
                    // MARK: Moving Header Based On Direction Scroll
                    if previous > current {
                        // MARK: Up
                        // print("Up")
                        if direction != .up && current < 0 {
                            shiftOffset = current - headerOffset
                            direction = .up
                            lastHeaderOffset = headerOffset
                        }
                        
                        let offset = current < 0 ? (current - shiftOffset) : 0
                        // MARK: Checking If It Does Not Go Over Header Height
                        headerOffset = (-offset < headerHeight ? (offset < 0 ? offset : 0) : -headerHeight)
                    } else {
                        // MARK: Down
                        // print("Down")
                        if direction != .down {
                            shiftOffset = current
                            direction = .down
                            lastHeaderOffset = headerOffset
                        }
                        
                        let offset = lastHeaderOffset + (current - shiftOffset)
                        headerOffset = (offset > 0 ? 0 : offset)
                    }
                }
            
            //Active now
            ActiveNowView(
                viewModel: vmActiveNow,
                onChatTapped: { user in
                    router
                        .showScreen(.push) { _ in
                            ChatView(user: user)
                }
            })
            
            // Resent Chats
            RecentChatsView(
                viewModel: vmInbox,
                onChatTapped: { user in
                    router
                        .showScreen(.push) { _ in
                            ChatView(user: user)
                }
            })
            
        }
        .background(Color.theme.darkBlack)
        .coordinateSpace(name: "SCROLL")
        .overlay(alignment: .top) {
            // Header
            InboxHeader(
                headerHeight: $headerHeight, headerOffset: $headerOffset, profileImage: CircularProfileImageView(user: vmInbox.user, size: .small40), username: vmInbox.user?.username ?? "",
                profileimageTapped: {
                    router.showScreen(.push) { _ in
                        if let user = vmInbox.user {
                            ProfileView(user: user)
                        }
                    }
                },
                searchTapped: {
                    
                },
                newChatTapped: {
                    router.showScreen(.fullScreenCover) { _ in
                        NewMessageView(selectedUser: $selectedUser)
                    }
                    selectedUser = nil
                }
            )
            .task {
              //  vmInbox.
            }
        }
        // MARK: Due To Safe Area
        .ignoresSafeArea(.all, edges: .top)
    }
    
}

#Preview {
    RouterView { _ in
        InboxView()
    }
}
