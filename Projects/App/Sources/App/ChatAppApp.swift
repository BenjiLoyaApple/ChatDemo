//
//  ChatAppApp.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import FirebaseCore
import SwiftfulRouting
import Components

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      
    FirebaseApp.configure()
      
    return true
  }
}

@main
struct ChatAppApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    /// Face ID
    @AppStorage("isFaceID") private var isFaceIDEnabled: Bool = false
    @State private var isAuthenticated = false
    @State private var errorMessage: String?
    
    var body: some Scene {
        WindowGroup {
            Group {
                if let errorMessage = errorMessage {
                    // Показываем ошибку если не прошел Face ID
                    CustomErrorView(
                        title: "Error",
                        imageName: "faceid",
                        description: errorMessage
                    )
                } else if isAuthenticated || !isFaceIDEnabled {
                    // Основное приложение
                    RouterView { _ in
                        RootView(content: ContentView())
                    }
                } else {
                    // Индикатор загрузки
                    ProgressView("Authenticating...")
                        .padding()
                }
            }
            .onAppear {
                FaceIDManager.authenticateIfNeeded(isFaceIDEnabled: isFaceIDEnabled) { success, errorMessage in
                    if success {
                        isAuthenticated = true
                    } else {
                        self.errorMessage = errorMessage
                    }
                }
            }
        }
    }
    
}
