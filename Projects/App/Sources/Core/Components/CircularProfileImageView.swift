//
//  CircularProfileImageView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import Kingfisher

enum ProfileImageSize {
    case small14
    case small20
    case small24
    case small28
    case small34
    case small40
    case medium46
    case medium50
    case large56
    case large60
    
    var dimension: CGFloat {
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
        }
    }
    
    var fontSize: CGFloat {
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
          }
      }
    
}

enum ProfileBackgroundColor: CaseIterable {
    case red, blue, green, orange, purple, yellow, pink, teal, mint
    
    var color: Color {
        switch self {
        case .red: return Color.red
        case .blue: return Color.blue
        case .green: return Color.green
        case .orange: return Color.orange
        case .purple: return Color.purple
        case .yellow: return Color.yellow
        case .pink: return Color.pink
        case .teal: return Color.teal
        case .mint: return Color.mint
        }
    }
}

struct UserInitialsView: View {
    let username: String
    let fontSize: CGFloat
    
    private var initials: String {
        let names = username.split(separator: " ")
        let firstInitial = names.first?.first?.uppercased() ?? ""
        let lastInitial = names.count > 1 ? names.last?.first?.uppercased() ?? "" : ""
        return "\(firstInitial)\(lastInitial)"
    }
    
    private var backgroundColor: Color {
            ProfileBackgroundColor.allCases.randomElement()?.color ?? Color.gray
        }
    
    var body: some View {
        Text(initials)
            .font(.system(size: fontSize, weight: .semibold))
            .frame(width: fontSize * 2, height: fontSize * 2)
            .background(backgroundColor.gradient)
            .foregroundColor(.white)
            .clipShape(Circle())
    }
}

// View
struct CircularProfileImageView: View {
    var user: User?
    let size: ProfileImageSize
    
    var body: some View {
        if let imageUrl = user?.profileImageUrl {
            KFImage(URL(string: imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                )
        } else {
            UserInitialsView(username: user?.username ?? "", fontSize: size.fontSize)
                .scaledToFill()
                .frame(width: size.dimension, height: size.dimension)
                .clipShape(Circle())
        }
    }
}


#Preview {
    CircularProfileImageView(size: .medium50)
}
