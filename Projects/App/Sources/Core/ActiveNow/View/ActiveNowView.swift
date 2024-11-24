//
//  ActiveNowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulUI

// MARK: - ActiveNowView
struct ActiveNowView: View {
    @ObservedObject var viewModel: ActiveNowViewModel
    var onChatTapped: ((User) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Active Now")
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundStyle(.primary.opacity(0.85))
                .padding(10)
                .padding(.leading, 5)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer(minLength: 0)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(spacing: 25) {
                    if !viewModel.isLoading {
                        ForEach(0..<10) { _ in
                            placeholderActiveNow()
                                
                        }
                    } else {
                        ForEach(viewModel.users) { user in
                            ActiveCell(
                                user: user,
                                profileImage: CircularProfileImageView(user: user, size: .large60),
                                username: user.username,
                                showChatTapped: {
                                    onChatTapped?(user)
                                }
                            )
                        }
                    }
                }
                .padding(.bottom, 5)
                .safeAreaPadding(.leading)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 140)
        .cornerRadius(15)
    }
}

// MARK: - Active Cell
struct ActiveCell<ProfileImageView: View>: View {
    var user: User
    let profileImage: ProfileImageView
    let username: String
    var showChatTapped: (() -> Void)? = nil
    
    var body: some View {
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

// MARK: - Preview with Mock Data
#Preview {
    ActiveNowView(viewModel: .mockActive)
}
