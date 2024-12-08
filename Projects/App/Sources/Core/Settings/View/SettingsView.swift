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

        // Инициализатор с внедрением зависимости
        init(authService: AuthServiceProtocol) {
            self.authService = authService
        }
    
    var body: some View {
        VStack(spacing: 10) {
            HeaderComponent(backButtonPressed: {
                router.dismissScreen()
            }, buttonImageSource: .systemName("chevron.left")) {
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
        .sheet(isPresented: $changeTheme, content: {
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
                Section {
                    //Saved
                    CustomButton(
                        imageName: "bookmark",
                        title: "Saved",
                        imageName2: "chevron.right"
                    ) {
                        print("Privacy tapped")
                    }
                    
                    //Archive
                    CustomButton(
                        imageName: "clock.arrow.trianglehead.counterclockwise.rotate.90",
                        title: "Archive",
                        imageName2: "chevron.right"
                    ) {
                        print("Privacy tapped")
                    }
                    
                    //Your activity
                    CustomButton(
                        imageName: "chart.xyaxis.line",
                        title: "Your activity",
                        imageName2: "chevron.right"
                    ) {
                        print("Privacy tapped")
                    }
                    
                    //Notifications
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
                    
                    //Time management
                    CustomButton(
                        imageName: "clock",
                        title: "Time management",
                        imageName2: "chevron.right"
                    ) {
                        print("Privacy tapped")
                    }
                } header: {
                    HStack {
                        Text("How to use ChatDemo")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                    .padding(.vertical, 10)
                    .padding(.bottom, 4)
                }
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(.gray.opacity(0.1))
                
                //MARK: - Your app and media
                Section {
                    CustomButton(
                        imageName: "character.square",
                        title: "Language",
                        imageName2: "chevron.right"
                    ) {
                        print("About tapped")
                    }
                    
                    CustomButton(
                        imageName: "moon",
                        title: "Theme"
                    ) {
                        changeTheme.toggle()
                    }
                    
                } header: {
                    HStack {
                        Text("Your app and media")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                }
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(.gray.opacity(0.1))
                
                
                
                
                //MARK: - More info and support
                Section {
                    CustomButton(
                        imageName: "questionmark.circle",
                        title: "Help"
                    ) {
                        print("About tapped")
                    }
                    
                    CustomButton(
                        imageName: "exclamationmark.shield",
                        title: "Privacy Center"
                    ) {
                        print("About tapped")
                    }
                    
                    CustomButton(
                        imageName: "person",
                        title: "Account Status"
                    ) {
                        print("About tapped")
                    }
                    
                    CustomButton(
                        imageName: "info.circle",
                        title: "About"
                    ) {
                        print("About tapped")
                    }
                    
                } header: {
                    HStack {
                        Text("More info and support")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                }
                
                Rectangle()
                    .frame(maxWidth: .infinity)
                    .frame(height: 4)
                    .foregroundStyle(.gray.opacity(0.1))
                
                
                
                //MARK: - Log Out
                Section {
                    CustomButton(
                        title: "Log Out"
                    ) {
                        Task {
                            do {
                                try await authService.signOut()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    router.dismissScreenStack()
                                }
                            } catch {
                                print("Ошибка при выходе из системы: \(error.localizedDescription)")
                            }
                        }
                    }
                    
                    CustomButton(
                        title: "Delete Account",
                        imageForegroundColor: .red,
                        textForegroundColor: .red
                    ) {
                        Task {
                            do {
                                try await authService.deleteUser()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    router.dismissScreenStack()
                                }
                            } catch {
                                print("Ошибка при удалении аккаунта: \(error.localizedDescription)")
                            }
                        }
                    }
                } header: {
                    HStack {
                        Text("Login")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 12)
                }
                
                
                
            }
        }
    }
    
    
}

#Preview {
    RouterView { _ in
        SettingsView(authService: MockAuthService())
    }
}


/*
 //MARK: - Section name
 Section {
    
     
 } header: {
     HStack {
         Text("Sectionname")
             .font(.footnote)
             .fontWeight(.semibold)
             .foregroundStyle(.gray)
     }
     .frame(maxWidth: .infinity, alignment: .leading)
     .padding(.leading, 12)
     .padding(.vertical, 10)
     .padding(.bottom, 4)
 }
 
 Rectangle()
     .frame(maxWidth: .infinity)
     .frame(height: 4)
     .foregroundStyle(.gray.opacity(0.1))
 
 */
