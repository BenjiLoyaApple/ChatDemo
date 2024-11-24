//
//  SettingsView.swift
//  Threads
//
//  Created by Benji Loya on 24.04.2023.
//

import SwiftUI
import SwiftfulRouting

struct SettingsView: View {
    @Environment(\.router) var router
    @Environment(\.colorScheme) private var scheme
    @State private var changeTheme: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @StateObject private var notification = NotificationsManager()
    
    private let authService: AuthServiceProtocol

        // Инициализатор с внедрением зависимости
        init(authService: AuthServiceProtocol) {
            self.authService = authService
        }
    
    var body: some View {
        VStack(spacing: 10) {
           
            HeaderView()
            
            OptionsView()
                .padding(.horizontal)
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme, content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
    
    // MARK: - Header
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center) {
                Button("Back") {
                    router.dismissScreen()
                }
                .font(.subheadline)
                .foregroundColor(Color.theme.primaryText)
                
                Spacer(minLength: 0)
                
                Text("Settings")
                    .offset(x: -15)
                
                Spacer(minLength: 0)
                
                
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
            
            Divider()
                .offset(y: 10)
        }
        .padding(.vertical)
    }
    
    // MARK: - Options
    @ViewBuilder
    private func OptionsView() -> some View {
        VStack(spacing: 10) {
            CustomButton(
                imageName: "bell",
                title: "Notifications"
            ) {
                Task {
                    await notification.request()
                }
            }
            .disabled(notification.hasPermission)
            .task {
                await notification.getAuthStatus()
            }
            
            CustomButton(
                imageName: "lock",
                title: "Privacy"
            ) {
                print("Privacy tapped")
            }
            
            CustomButton(
                imageName: "person",
                title: "Account"
            ) {
                print("Account tapped")
            }
            
            CustomButton(
                imageName: "moon",
                title: "Theme"
            ) {
                changeTheme.toggle()
            }
            
            CustomButton(
                imageName: "questionmark.app",
                title: "Help"
            ) {
                print("Help tapped")
            }
            
            CustomButton(
                imageName: "info.square",
                title: "About"
            ) {
                print("About tapped")
            }
            
            Divider()
            
            CustomButton(
                imageName: "power",
                title: "Log Out"
            ) {
                Task {
                    do {
                        try await authService.signOut()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            router.dismissScreen()
                        }
                    } catch {
                        print("Ошибка при выходе из системы: \(error.localizedDescription)")
                    }
                }
            }
            
            CustomButton(
                imageName: "puzzlepiece.extension",
                title: "Delete Account",
                imageForegroundStyle: .red,
                textForegroundStyle: .red
            ) {
                Task {
                    do {
                        try await authService.deleteUser()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            router.dismissScreen()
                        }
                    } catch {
                        print("Ошибка при удалении аккаунта: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { _ in
            SettingsView(authService: EmailAuthProvider() as! AuthServiceProtocol)
        }
    }
}
