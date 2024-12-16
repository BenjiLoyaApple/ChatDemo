//
//  ChatOptionsMenu.swift
//  Components
//
//  Created by Benji Loya on 03.12.2024.
//

import SwiftUI

public struct ChatOptionsMenu: View {
    // Menu Properties
    public var username: String?
    public var pinButtonTapped: (() -> Void)? = nil
    public var shareButtonTapped: (() -> Void)? = nil
    public var deleteForMeButtonTapped: (() -> Void)? = nil
    public var deleteAllButtonTapped: (() -> Void)? = nil
    public var clearButtonTapped: (() -> Void)? = nil
    public var notificationButtonTapped: (() -> Void)? = nil
    public var blockUserButtonTapped: (() -> Void)? = nil
    
    // MARK: - init
    public init(
        username: String = "",
        pinButtonTapped: (() -> Void)? = nil,
        shareButtonTapped: (() -> Void)? = nil,
        deleteForMeButtonTapped: (() -> Void)? = nil,
        deleteAllButtonTapped: (() -> Void)? = nil,
        clearButtonTapped: (() -> Void)? = nil,
        notificationButtonTapped: (() -> Void)? = nil,
        blockUserButtonTapped: (() -> Void)? = nil
    ) {
        self.username = username
        self.pinButtonTapped = pinButtonTapped
        self.shareButtonTapped = shareButtonTapped
        self.deleteForMeButtonTapped = deleteForMeButtonTapped
        self.deleteAllButtonTapped = deleteAllButtonTapped
        self.clearButtonTapped = clearButtonTapped
        self.notificationButtonTapped = notificationButtonTapped
        self.blockUserButtonTapped = blockUserButtonTapped
    }
    
    public var body: some View {
        Menu {
            /// Pin
            ControlGroup {
#if DEBUG
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
#endif
                /// Delete
                Menu {
                    /// For Me
                    Button(role: .destructive) {
                        deleteForMeButtonTapped?()
                    } label: {
                        Label("For me", systemImage: "person")
                    }
#if DEBUG
                    /// For All Users
                    Button {
                        deleteAllButtonTapped?()
                    } label: {
                        Image(systemName: "person.2")
                        Text("For me & \(username ?? "")")
                    }
#endif
                } label: {
                    Image(systemName: "arrow.up.trash")
                    Text("Delete")
                }

            }
#if DEBUG
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
            
            /// Block user
            Button(role: .destructive) {
                blockUserButtonTapped?()
            } label: {
                Text("Block user")
                Image(systemName: "hand.raised")
            }
#endif
        } label: {
            CustomChatButton(
                imageSource: .systemName("ellipsis"),
                font: .subheadline,
                foregroundColor: .gray,
                padding: 15
            )
        }
    }
}

#Preview {
    ChatOptionsMenu()
}
