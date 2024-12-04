//
//  ActiveCell.swift
//  Components
//
//  Created by Benji Loya on 03.12.2024.
//

import SwiftUI
import SwiftfulUI

public struct ActiveCell<ProfileImageView: View, UserType: UserRepresentable>: View {
    public var user: UserType
    public let profileImage: ProfileImageView
    public let username: String
    public var showChatTapped: (() -> Void)? = nil
    public let startColor: Color
    public let endColor: Color

    // MARK: - Init
    public init(
        user: UserType,
        profileImage: ProfileImageView,
        username: String,
        startColor: Color,
        endColor: Color,
        showChatTapped: (() -> Void)? = nil
    ) {
        self.user = user
        self.profileImage = profileImage
        self.username = username
        self.startColor = startColor
        self.endColor = endColor
        self.showChatTapped = showChatTapped
    }

    public var body: some View {
        VStack(spacing: 8) {
            profileImage
                .padding(6)
                .overlay(
                    Circle()
                        .strokeBorder(
                            LinearGradient(colors: [startColor, endColor], startPoint: .topLeading, endPoint: .bottomTrailing).opacity(0.95),
                            lineWidth: 3
                        )
                )
                .asButton(.press) {
                    showChatTapped?()
                }
            
            Text(username)
                .font(.caption)
                .foregroundColor(.primary.opacity(0.8))
        }
    }
}

// MARK: - Preview
#Preview {
    let mockUser = MockUser(id: "1", username: "Benji Loya")
    ActiveCell(
        user: mockUser,
        profileImage: Circle()
            .frame(width: 66, height: 66)
            .foregroundStyle(.blue.opacity(0.25).gradient),
        username: mockUser.username,
        startColor: .red,
        endColor: .orange
    )
}
