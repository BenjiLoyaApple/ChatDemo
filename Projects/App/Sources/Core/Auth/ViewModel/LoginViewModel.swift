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
        defer { isAuthenticating = false }
        
        do {
            try await authService.login(withEmail: email, password: password)
        } catch {
            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
            self.showAlert = true
            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
            throw error
        }
    }
    
    
    @MainActor
    func resetPassword() async throws {
        guard !email.isEmpty else {
            print("Please enter your email to reset your password.")
            return
        }
        
        do {
            try await authService.resetPassword(email: email)
            print("Password reset email sent.")
        } catch {
            print("Failed to send password reset email: \(AuthErrorCode.invalidEmail)")
        }
        
    }
    
}

// MARK: - RegistrationViewModel

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
        defer { isAuthenticating = false }

        do {
            try await authService.createUser(
                withEmail: email,
                password: password,
                username: username,
                fullname: fullname
            )
        } catch {
            // Обрабатываем код ошибки
            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
            showAlert = true
            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
            throw error
        }
    }
    
    @MainActor
    func verificationEmail() async throws {
        // made new code
    }
    
    func resetPassword() async throws {
        // made new code
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
