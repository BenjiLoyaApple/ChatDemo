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
    
    @StateObject private var notification = NotificationsManager()
    @StateObject private var settingsViewModel = SettingsViewModel()
    
    private let authService: AuthServiceProtocol
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @AppStorage("isFaceID") private var isFaceIDEnabled: Bool = false
    
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
#if DEBUG
                SectionView(title: "How to use ChatDemo",items: [
                    SectionItem(
                        icon: "bookmark",
                        title: "Saved",
                        trailingIcon: "chevron.right") {
                            router.showScreen(.push) { _ in
                                SavedView()
                                    .navigationBarBackButtonHidden()
                                    .background(Color.theme.darkBlack)
                            }
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
                        icon: "character.square",
                        title: "Language",
                        trailingIcon: "chevron.right") {
                            router.showScreen(.push) { _ in
                                LanguageView()
                                    .navigationBarBackButtonHidden()
                                    .background(Color.theme.darkBlack)
                            }
                        },
                    SectionItem(
                        icon: "clock",
                        title: "Time management",
                        trailingIcon: "chevron.right") {
                            print("Time management tapped")
                        }
                ])
                
                DividerView()
#endif
                //MARK: - Your app and media
                SectionView(title: "Your app and media",items: [
                    SectionItem(
                        icon: "bell",
                        title: "Notifications",
                        isDisabled: notification.hasPermission) {
                            Task { await notification.request()}
                        },
                    SectionItem(
                        icon: "faceid",
                        title: "Faсe ID",
                        trailingIcon: "chevron.right") {
                            router.showScreen(.push) { _ in
                                FaceIdView()
                            }
                        },
                    SectionItem(
                        icon: "person.and.background.dotted",
                        title: "Photos Access",
                        trailingIcon: "chevron.right") {
                            router.showScreen(.push) { _ in
                                PhotoPermissionView()
                            }
                        },
                    SectionItem(
                        icon: "moon",
                        title: "Theme") {
                            changeTheme.toggle()
                        }
                ])
                
                DividerView()
                
#if DEBUG
                //MARK: - Who can see yor content
                SectionView(title: "Who can see yor content",items: [
                    SectionItem(
                        icon: "lock",
                        title: "Account Privacy",
                        trailingIcon: "chevron.right") {
                            print("Help tapped")
                        },
                    SectionItem(
                        icon: "star.circle",
                        title: "Close friends",
                        trailingIcon: "chevron.right") {
                            print("Privacy Center tapped")
                        },
                    SectionItem(
                        icon: "square.grid.2x2",
                        title: "Crossposting",
                        trailingIcon: "chevron.right") {
                            print("Account Status tapped")
                        },
                    SectionItem(
                        icon: "nosign",
                        title: "Blocked",
                        trailingIcon: "chevron.right") {
                            print("About tapped")
                        },
                    SectionItem(
                        icon: "circle.bottomrighthalf.checkered",
                        title: "Hide story and live",
                        trailingIcon: "chevron.right") {
                            print("Account Status tapped")
                        }
                ])
                
                DividerView()
                
                //MARK: - What you see
                SectionView(title: "What you see",items: [
                    SectionItem(
                        icon: "star",
                        title: "Favorites",
                        trailingIcon: "chevron.right") {
                            print("Help tapped")
                        },
                    SectionItem(
                        icon: "bell.slash",
                        title: "Muted accounts",
                        trailingIcon: "chevron.right") {
                            print("Privacy Center tapped")
                        },
                    SectionItem(
                        icon: "play.square.stack",
                        title: "Suggested content",
                        trailingIcon: "chevron.right") {
                            print("Account Status tapped")
                        },
                    SectionItem(
                        icon: "heart.slash",
                        title: "Like and share counts",
                        trailingIcon: "chevron.right") {
                            print("About tapped")
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
#endif
                
                let debugViewEnvs: [BuildEnvironment] = [.dev]
                if debugViewEnvs.contains(where: { GlobalSettings.environment == $0 }) {
                    
                    SectionView(title: "Debug Only Section", items: [
                        SectionItem(
                            icon: "hammer",
                            title: "Debug Option 1",
                            trailingIcon: "chevron.right"
                        ) {
                            print("Debug Option 1 tapped")
                        },
                        SectionItem(
                            icon: "wrench",
                            title: "Debug Option 2",
                            trailingIcon: "chevron.right"
                        ) {
                            print("Debug Option 2 tapped")
                        }
                    ])
                    
                    DividerView()
                }
                
                
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
                            isFaceIDEnabled = false
                        },
                    SectionItem(
                        title: "Delete Account",
                        textForegroundColor: .red) {
                            Task {
                                do {
                                    try await authService.deleteUser()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        router.dismissScreenStack()}
                                } catch {
                                    print("Ошибка при удалении аккаунта: \(error.localizedDescription)")
                                }
                            }
                            isFaceIDEnabled = false
                        }
                ])
            }
        }
    }
}

#Preview {
    RouterView { _ in
        SettingsView(authService: MockAuthService())
    }
}




// MARK: - SavedView
struct SavedView: View {
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            HeaderComponent(backButtonPressed: { router.dismissScreen() },buttonImageSource: .systemName("chevron.left")) {
                
                Spacer(minLength: 0)
                
                Text("Saved")
                    .font(.subheadline.bold())
                    .offset(x: -20)
                    .padding(.vertical, 8)
                
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
        }
    }
}

// MARK: - LanguageView
struct LanguageView: View {
    @Environment(\.router) var router
    
    var body: some View {
        VStack {
            HeaderComponent(backButtonPressed: { router.dismissScreen() },buttonImageSource: .systemName("chevron.left")) {
                
                Spacer(minLength: 0)
                
                Text("Language")
                    .font(.subheadline.bold())
                    .offset(x: -20)
                    .padding(.vertical, 8)
                
                Spacer(minLength: 0)
            }
            
            Spacer(minLength: 0)
            
        }
    }
}



/*
let debugViewEnvs: [BuildEnvironment] = [.dev]

if debugViewEnvs.contains(where: { GlobalSettings.environment == $0 }) {
   
    SectionView(title: "Debug Only Section", items: [
        SectionItem(
            icon: "hammer",
            title: "Debug Option 1",
            trailingIcon: "chevron.right"
        ) {
            print("Debug Option 1 tapped")
        },
        SectionItem(
            icon: "wrench",
            title: "Debug Option 2",
            trailingIcon: "chevron.right"
        ) {
            print("Debug Option 2 tapped")
        }
    ])

    DividerView()
}
*/
