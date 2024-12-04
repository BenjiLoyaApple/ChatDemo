//
//  ActiveNowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import SwiftfulUI
import Components

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
                LazyHStack(spacing: 14) {
                    if !viewModel.isLoading {
                        ForEach(0..<10) { _ in
                            placeholderActiveNow()
                        }
                    } else {
                        ForEach(viewModel.users) { user in
                            ActiveCell(
                                user: user,
                                profileImage: CircularProfileImageView(user: user, size: .large66),
                                username: user.username,
                                startColor: .red,
                                endColor: .orange,
                                showChatTapped: {
                                    onChatTapped?(user)
                                }
                            )
                        }
                    }
                }
                .padding(.top, 3)
                .padding(.bottom, 5)
                .safeAreaPadding(.leading, 10)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 146)
    }
}

// MARK: - Preview with Mock Data
#Preview {
    ActiveNowView(viewModel: .mockActive)
}

