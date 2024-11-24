//
//  FeedHeader.swift
//  MyThreads
//
//  Created by Benji Loya on 23.07.2024.
//

import SwiftUI
import SwiftfulUI

// MARK: Swipe Direction
enum SwipeDirection {
    case up
    case down
    case none
}

struct InboxHeader<ProfileImageView: View>: View {
    @Binding var headerHeight: CGFloat
    @Binding var headerOffset: CGFloat

    let profileImage: ProfileImageView
    let username: String
    var profileimageTapped: (() -> Void)? = nil
    var searchTapped: (() -> Void)? = nil
    var newChatTapped: (() -> Void)? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 10) {
                profileImage
                    .asButton(.press) {
                        profileimageTapped?()
                    }
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(username)
                        .font(.system(size: 20, weight: .semibold))
                }
                
                Spacer(minLength: 0)
                
                HStack(spacing: 2) {
                    // Search
                    CustomChatButton(
                        imageName: .systemName("magnifyingglass"),
                        font: .title2,
                        foregroundStyle: .primary,
                        padding: 10,
                        onButtonPressed: {
                            searchTapped?()
                        }
                    )
                    
                    CustomChatButton(
                        imageName: .assetName("pen"),
                        foregroundStyle: .primary,
                        padding: 10,
                        frame: CGSize(width: 23, height: 23),
                        onButtonPressed: {
                            newChatTapped?()
                        }
                    )
                }
            }
            .padding(.horizontal, 15)
            
            Divider()
                .offset(y: 10)
                .opacity(0.5)
        }
        .padding(.top, safeArea().top)
        .background {
            Color.theme.darkBlack
        }
        .padding(.bottom, 10)
        .anchorPreference(key: HeaderBoundsKey.self, value: .bounds) { $0 }
        .overlayPreferenceValue(HeaderBoundsKey.self) { value in
            GeometryReader { proxy in
                if let anchor = value {
                    Color.clear
                        .onAppear {
                            // MARK: Retrieving Rect Using Proxy
                            headerHeight = proxy[anchor].height
                        }
                }
            }
        }
        .offset(y: -headerOffset < headerHeight ? headerOffset : (headerOffset < 0 ? headerOffset : 0))
    }
}

#Preview {
    InboxView()
}
