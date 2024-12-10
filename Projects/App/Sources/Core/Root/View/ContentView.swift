//
//  ContentView.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ContentViewModel()
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    // Face ID
    @AppStorage("isFaceIDEnabled") private var isFaceIDEnabled: Bool = false
        @State private var isAuthenticated = false
        @State private var errorMessage: String?
    
    
//    var body: some View {
//        Group {
//            if viewModel.userSession != nil {
//                InboxView()
//            } else {
//               IntrosView()
//            }
//        }
//        .preferredColorScheme(userTheme.colorScheme)
//    }
    
    var body: some View {
            Group {
                if let errorMessage = errorMessage {
                    ErrorView(message: errorMessage)
                } else if isAuthenticated || !isFaceIDEnabled {
                    if viewModel.userSession != nil {
                        InboxView()
                    } else {
                        IntrosView()
                    }
                }
            }
            .preferredColorScheme(userTheme.colorScheme)
            .onAppear {
                authenticateIfNeeded()
            }
        }
    
    private func authenticateIfNeeded() {
            guard isFaceIDEnabled else {
                isAuthenticated = true
                return
            }
            
            FaceIDManager.authenticate(reason: "Authenticate to access the app.") { success, errorMessage in
                if success {
                    isAuthenticated = true
                } else {
                    self.errorMessage = errorMessage
                }
            }
        }
    
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}


struct ErrorView: View {
    let message: String
    
    var body: some View {
        VStack {
            Text("Error")
                .font(.largeTitle)
                .bold()
                .padding(.bottom, 16)
            
            Text(message)
                .multilineTextAlignment(.center)
                .padding()
            
            Button("Try Again") {
                // Логика для повторной аутентификации
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red.opacity(0.1))
    }
}
