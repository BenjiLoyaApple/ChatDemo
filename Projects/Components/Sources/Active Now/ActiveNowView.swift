//
//  ActiveNowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

/*
import SwiftUI
import SwiftfulUI

public struct ActiveNowView<ViewModel: ActiveNowViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    public var onChatTapped: ((ViewModel.UserType) -> Void)?
    
    public init(
        viewModel: ViewModel,
        onChatTapped: ((ViewModel.UserType) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.onChatTapped = onChatTapped
    }
    
    public var body: some View {
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
                           // placeholderActiveNow()
                        }
                    } else {
                        ForEach(viewModel.users) { user in
                            ActiveCell(
                                user: user,
                                profileImage: CircularProfileImageView(user: user, size: .large66),
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

#Preview {
    let mockUsers = [
        MockUser(id: "1", username: "Benji Loya"),
        MockUser(id: "2", username: "Alice Smith"),
        MockUser(id: "3", username: "John Doe")
    ]
    
    let viewModel = MockActiveNowViewModel(users: mockUsers, isLoading: true)
    
    ActiveNowView(viewModel: viewModel) { user in
        print("Tapped on user: \(user.username)")
    }
}
*/
