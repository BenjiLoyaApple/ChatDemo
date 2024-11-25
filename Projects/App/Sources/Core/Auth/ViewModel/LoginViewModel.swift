//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isAuthenticating = false
    @Published var showAlert = false
    @Published var authError: AuthError?
    
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
        self.authService = authService
    }
    
    @MainActor
    func login() async throws {
        isAuthenticating = true
        
        do {
            try await authService.login(withEmail: email, password: password)
            isAuthenticating = false
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true
            isAuthenticating = false
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
        }
    }
}

class RegistrationViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var username = ""
    @Published var fullname = ""
    @Published var showAlert = false
    @Published var authError: AuthError?
    @Published var isAuthenticating = false
    
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
        self.authService = authService
    }
    
    @MainActor
    func createUser() async throws {
        isAuthenticating = true
        do {
            try await authService.createUser(
                withEmail: email,
                password: password,
                username: username,
                fullname: fullname
            )
            isAuthenticating = false
        } catch {
            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
            showAlert = true
            isAuthenticating = false
            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
        }
    }
}

extension LoginViewModel: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
               email.contains("@") &&
               !password.isEmpty
    }
}

extension RegistrationViewModel: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty &&
               email.contains("@") &&
               !password.isEmpty &&
               password.count > 5 &&
               !username.isEmpty &&
               username.count <= 15
    }
}
