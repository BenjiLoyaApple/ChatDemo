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

    // MARK: - Init
    public init(
        user: UserType,
        profileImage: ProfileImageView,
        username: String,
        showChatTapped: (() -> Void)? = nil
    ) {
        self.user = user
        self.profileImage = profileImage
        self.username = username
        self.showChatTapped = showChatTapped
    }

    public var body: some View {
        VStack {
            profileImage
                .asButton(.press) {
                    showChatTapped?()
                }
            Text(username)
                .font(.footnote)
                .foregroundColor(.primary.opacity(0.8))
        }
    }
}

// MARK: - Preview
#Preview {
    let mockUser = MockUser(username: "Benji Loya")
    ActiveCell(
        user: mockUser,
        profileImage: Circle()
            .frame(width: 66, height: 66)
            .foregroundStyle(.blue.opacity(0.25).gradient),
        username: mockUser.username
    )
}
