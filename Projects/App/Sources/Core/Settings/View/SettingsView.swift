//
//  SettingsView.swift
//  Threads
//
//  Created by Benji Loya on 24.04.2023.
//

import SwiftUI
import SwiftfulRouting
import Components

struct SettingsView: View {
    @Environment(\.router) var router
    @Environment(\.colorScheme) private var scheme
    @State private var changeTheme: Bool = false
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @StateObject private var notification = NotificationsManager()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol) {
        self.authService = authService
    }
    
    var body: some View {
        VStack( spacing: 10) {
            HeaderComponent(backButtonPressed: { router.dismissScreen() },buttonImageSource: .systemName("chevron.left")) {
                
                Spacer(minLength: 0)
                
                Text("Settings and activity")
                    .font(.subheadline.bold())
                    .offset(x: -20)
                    .padding(.vertical, 8)
                
                Spacer(minLength: 0)
            }
            
            OptionsView()
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.darkBlack)
        .preferredColorScheme(userTheme.colorScheme)
        .sheet(isPresented: $changeTheme,content: {
            ThemeChangeView(scheme: scheme)
                .presentationDetents([.height(410)])
                .presentationBackground(.clear)
        })
    }
    
    // MARK: - Options
    @ViewBuilder
    private func OptionsView() -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10) {
                //MARK: - How to use ChatDemo
                SectionView(title: "How to use ChatDemo",items: [
                        SectionItem(
                            icon: "bookmark",
                            title: "Saved",
                            trailingIcon: "chevron.right") {
                            print("Saved tapped")
                        },
                        SectionItem(
                            icon: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                            title: "Archive",
                            trailingIcon: "chevron.right") {
                            print("Archive tapped")
                        },
                        SectionItem(
                            icon: "chart.xyaxis.line",
                            title: "Your activity",
                            trailingIcon: "chevron.right") {
                            print("Your activity tapped")
                        },
                        SectionItem(
                            icon: "bell",
                            title: "Notifications",
                            isDisabled: notification.hasPermission) {
                            Task { await notification.request()}
                        },
                        SectionItem(
                            icon: "clock",
                            title: "Time management",
                            trailingIcon: "chevron.right") {
                            print("Time management tapped")
                        }
                    ])
                
                DividerView()
                
                //MARK: - Your app and media
                SectionView(title: "Your app and media",items: [
                        SectionItem(
                            icon: "character.square",
                            title: "Language",
                            trailingIcon: "chevron.right") {
                            print("Language tapped")
                        },
                        SectionItem(
                            icon: "moon",
                            title: "Theme") {
                            changeTheme.toggle()
                        }
                    ])
                
                DividerView()
                
                //MARK: - More info and support
                SectionView(title: "More info and support",items: [
                        SectionItem(
                            icon: "questionmark.circle",
                            title: "Help",
                            trailingIcon: "chevron.right") {
                            print("Help tapped")
                        },
                        SectionItem(
                            icon: "exclamationmark.shield",
                            title: "Privacy Center",
                            trailingIcon: "chevron.right") {
                            print("Privacy Center tapped")
                        },
                        SectionItem(
                            icon: "person",
                            title: "Account Status",
                            trailingIcon: "chevron.right") {
                            print("Account Status tapped")
                        },
                        SectionItem(
                            icon: "info.circle",
                            title: "About",
                            trailingIcon: "chevron.right") {
                            print("About tapped")
                        }
                    ])
                
                DividerView()
                
                //MARK: - Login
                SectionView(title: "Login",items: [
                        SectionItem(
                            title: "Log Out") {
                            Task {
                                do {
                                    try await authService.signOut()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            router.dismissScreenStack()}
                                } catch {
                                    print("Ошибка при выходе из системы: \(error.localizedDescription)")
                                }
                            }
                        },
                        SectionItem(
                            title: "Delete Account",
                            textForegroundColor: .red
                        ) {
                            Task {
                                do {
                                    try await authService.deleteUser()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            router.dismissScreenStack()}
                                } catch {
                                    print("Ошибка при удалении аккаунта: \(error.localizedDescription)")
                                }
                            }
                        }
                    ]
                )
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SettingsView(authService: MockAuthService())
    }
}
