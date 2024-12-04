//
//  ActiveNowView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

/*
import SwiftUI
import SwiftfulUI

public struct ActiveNowView<
    ProfileImageView: View,
    ViewModel: ActiveNowViewModelProtocol
>: View {
    @ObservedObject public var viewModel: ViewModel
    public let profileImage: (ViewModel.UserType) -> ProfileImageView
    public var onChatTapped: ((ViewModel.UserType) -> Void)?
    
    public init(
        viewModel: ViewModel,
        profileImage: @escaping (ViewModel.UserType) -> ProfileImageView,
        onChatTapped: ((ViewModel.UserType) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.profileImage = profileImage
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
                    if viewModel.isLoading {
//                        ForEach(viewModel.users, id: \.id) { user in
//                            ActiveCell(
//                                user: user,
//                                profileImage: profileImage(user),
//                                username: user.username,
//                                showChatTapped: {
//                                    onChatTapped?(user)
//                                }
//                            )
//                        }
                    } else {
                        ForEach(0..<10, id: \.self) { _ in
                        //    placeholderActiveNow()
                            Text("")
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
 
}
*/
