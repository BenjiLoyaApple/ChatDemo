//
//  CircularProfileImageView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//


import SwiftUI
import Kingfisher

/// Размеры профиля с предопределенными размерами
public enum ProfileImageSize {
    case small14, small20, small24, small28, small34, small40, medium46, medium50, large56, large60, large66, large72
    
    public var dimension: CGFloat {
        switch self {
        case .small14: return 14
        case .small20: return 20
        case .small24: return 24
        case .small28: return 28
        case .small34: return 34
        case .small40: return 40
        case .medium46: return 46
        case .medium50: return 50
        case .large56: return 56
        case .large60: return 60
        case .large66: return 66
        case .large72: return 72
        }
    }
    
    public var fontSize: CGFloat {
        switch self {
        case .small14: return 7
        case .small20: return 10
        case .small24: return 12
        case .small28: return 14
        case .small34: return 17
        case .small40: return 20
        case .medium46: return 23
        case .medium50: return 25
        case .large56: return 28
        case .large60: return 30
        case .large66: return 33
        case .large72: return 36
        }
    }
}

/// Цвета фона для инициалов пользователя
public enum ProfileBackgroundColor: CaseIterable {
    case red, blue, green, orange, purple, yellow, pink, teal, mint
    
    public var color: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .orange: return .orange
        case .purple: return .purple
        case .yellow: return .yellow
        case .pink: return .pink
        case .teal: return .teal
        case .mint: return .mint
        }
    }
}

/// Компонент для отображения инициалов пользователя
public struct UserInitialsView: View {
    private let username: String
    private let fontSize: CGFloat
    private let backgroundColor: Color
    
    /// Инициализатор
    public init(username: String, fontSize: CGFloat) {
        self.username = username
        self.fontSize = fontSize
        self.backgroundColor = ProfileBackgroundColor.allCases.randomElement()?.color ?? .gray
    }
    
    private var initials: String {
        let names = username.split(separator: " ")
        let firstInitial = names.first?.first?.uppercased() ?? ""
        let lastInitial = names.count > 1 ? names.last?.first?.uppercased() ?? "" : ""
        return "\(firstInitial)\(lastInitial)"
    }
    
    public var body: some View {
        Text(initials)
            .font(.system(size: fontSize, weight: .semibold))
            .frame(width: fontSize * 2, height: fontSize * 2)
            .background(backgroundColor.gradient)
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

/// Компонент для отображения круглой картинки профиля или инициалов
public struct CircularProfileImageView: View {
    private let user: ProfileRepresentable?
    private let size: ProfileImageSize
    
    /// Инициализатор
    public init(user: ProfileRepresentable?, size: ProfileImageSize) {
        self.user = user
        self.size = size
    }
    
    public var body: some View {
        if let imageUrl = user?.profileImageUrl, let url = URL(string: imageUrl) {
            KFImage(url)
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                )
        } else {
            UserInitialsView(username: user?.username ?? "?", fontSize: size.fontSize)
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        // С изображением профиля
        CircularProfileImageView(
            user: MockProfile(
                profileImageUrl: "https://via.placeholder.com/150",
                username: "John Doe"
            ),
            size: .large72
        )
        
        // Без изображения (инициалы)
        CircularProfileImageView(
            user: MockProfile(
                profileImageUrl: nil,
                username: "benjiloya"
            ),
            size: .large72
        )
    }
    .padding()
}

