//
//  RegisterViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import FirebaseAuth

//class LoginViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var isAuthenticating = false
//    @Published var showAlert = false
//    @Published var authError: AuthError?
//    
//    @MainActor
//    func login() async throws {
//        isAuthenticating = true
//        
//        do {
//            try await AuthService.shared.login(withEmail: email, password: password)
//            isAuthenticating = false
//        } catch {
//            let authError = AuthErrorCode.Code(rawValue: (error as NSError).code)
//            self.showAlert = true
//            isAuthenticating = false
//            self.authError = AuthError(authErrorCode: authError ?? .userNotFound)
//        }
//    }
//}

//class RegistrationViewModel: ObservableObject {
//    @Published var email = ""
//    @Published var password = ""
//    @Published var username = ""
//    @Published var fullname = ""
//    @Published var showAlert = false
//    @Published var authError: AuthError?
//    @Published var isAuthenticating = false
//    
//    @MainActor
//    func createUser() async throws {
//        isAuthenticating = true
//        do {
//            try await AuthService.shared.createUser(
//                withEmail: email,
//                password: password,
//                username: username,
//                fullname: fullname
//            )
//            isAuthenticating = false
//        } catch {
//            let authErrorCode = AuthErrorCode.Code(rawValue: (error as NSError).code)
//            showAlert = true
//            isAuthenticating = false
//            authError = AuthError(authErrorCode: authErrorCode ?? .userNotFound)
//        }
//    }
//}
