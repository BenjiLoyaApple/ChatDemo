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
