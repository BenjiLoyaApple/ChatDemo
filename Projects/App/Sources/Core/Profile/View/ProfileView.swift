//
//  ProfileView.swift
//  ChatApp
//
//  Created by Benji Loya on 09.08.2023.
//

import SwiftUI
import PhotosUI
import SwiftfulRouting
import Components

struct ProfileView: View {
    
    @Environment(\.router) var router
    @StateObject var vmInbox = InboxViewModel()
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            if let user = vmInbox.user {
                ProfileHome(user: user, size: size, safeArea: safeArea)
                    .ignoresSafeArea()
            }
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
    }
}

#Preview {
    RouterView { _ in
        ProfileView()
    }
}


/*
import SwiftUI
import PhotosUI
import SwiftfulRouting
import Components

struct ProfileView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ProfileViewModel()
    
    let user: User
 
    /// - View Properties
    @State private var showPicker: Bool = false
    @State private var croppedImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
       //     HeaderView()
            
            HeaderComponent(backButtonPressed: {
                router.dismissScreen()
                Task {
                    try? await viewModel.loadCurrentUser()
                }
            }, buttonImageSource: .systemName("chevron.left")) {
                Spacer(minLength: 0)
                
                Text(viewModel.username)
                    .font(.subheadline.bold())
                    .offset(x: 10)
                
                Spacer(minLength: 0)
                
                CustomChatButton(
                    text: "Done",
                    font: .subheadline,
                    foregroundColor: Color.theme.primaryText,
                    padding: 5
                ) {
                    router.dismissScreen()
                    Task {
                        try await viewModel.updateUserData()
                        try? await viewModel.loadCurrentUser()
                    }
                }
            }
            
            Spacer()
            
            UserView()
                .padding()
                .task {
                    viewModel.loadUserData()
                }
            
            Spacer()
            
            Text("Settings")
                .onTapGesture {
                    router.showScreen(.push) { _ in
                        SettingsView(authService: DIContainer.shared.authService)
                    }
                }
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
    }
    
    // MARK: - User
    @ViewBuilder
    private func UserView() -> some View {
        VStack(alignment: .leading, spacing: 11) {
            HStack {
                VStack(alignment: .leading) {
                    Text("Name")
                        .fontWeight(.semibold)
                    
                    TextField("username", text: $viewModel.username)
                        .onChange(of: viewModel.username) { _, newValue in
                            if newValue.count > 20 {
                                viewModel.username = String(newValue.prefix(20))
                            }
                        }
                }
                .font(.footnote)
                
                Spacer()
                
                /// Profile Image
                if let croppedImage {
                    Image(uiImage: croppedImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .onAppear {
                            Task {
                                await viewModel.handleCroppedImage(croppedImage)
                            }
                        }
                } else {
                    CircularProfileImageView(user: user, size: .small40)
                        .onTapGesture {
                            showPicker.toggle()
                        }
                }
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Bio")
                    .fontWeight(.semibold)
                
                TextField("Enter you bio..", text: $viewModel.bio, axis: .vertical)
            }
            .font(.footnote)
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Link")
                    .fontWeight(.semibold)
                
                TextField("Add link...", text: $viewModel.link)
            }
            .font(.footnote)
            
            Divider()
        }
        .padding()
        .cornerRadius(15)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color(.systemGray4), lineWidth: 0.5)
        }
        .cropImagePicker(
            options: [.circle, .custom(.init(width: 300, height: 300))],
            show: $showPicker,
            croppedImage: $croppedImage
        )
    }
}

#Preview {
    RouterView { _ in
        ProfileView(user: .mock)
    }
}
*/
