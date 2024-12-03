//
//  ActiveCell.swift
//  Components
//
//  Created by Benji Loya on 03.12.2024.
//

import SwiftUI
import SwiftfulUI

// Простая модель для пользователя
public struct User: Identifiable {
    public let id: UUID
    public let username: String
    
    // Пример инициализатора
    public init(id: UUID = UUID(), username: String) {
        self.id = id
        self.username = username
    }
}

public struct ActiveCell<ProfileImageView: View>: View {
    public var user: User 
    public let profileImage: ProfileImageView
    public let username: String
    public var showChatTapped: (() -> Void)? = nil

    // MARK: - Init
    public init(
        user: User,
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
    let mockUser = User(username: "John Doe")
    ActiveCell(
        user: mockUser,
        profileImage: Circle()
            .frame(width: 66, height: 66)
            .foregroundStyle(.blue),
        username: mockUser.username
    )
}
