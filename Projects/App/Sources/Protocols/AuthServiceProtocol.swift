//
//  AuthenticationFormProtocol.swift
//  Threads
//
//  Created by Benji Loya on 01.09.2023.
//

import Foundation
import FirebaseAuth
import Combine
//import Models

protocol AuthServiceProtocol {
    var userSession: FirebaseAuth.User? { get }
    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> { get }
    
    func login(withEmail email: String, password: String) async throws
    func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws
    func resetPassword(email: String) async throws
    func signOut() async throws
    func deleteUser() async throws
}

protocol AuthenticationFormProtocol {
    var formIsValid: Bool { get }
}

protocol AuthProviderProtocol {
    var userSession: FirebaseAuth.User? { get }
    
    func signIn(email: String, password: String) async throws
    func createUser(email: String, password: String, username: String, fullname: String?) async throws
    func signOut() async throws
    func deleteUser() async throws
}

enum AuthProviderType {
    case email
    case google
    case apple
}

class AuthProviderFactory {
    static func createProvider(type: AuthProviderType) -> AuthProviderProtocol {
        switch type {
        case .email:
            return EmailAuthProvider()
        case .google:
            fatalError("GoogleAuthProvider not implemented")
        case .apple:
            fatalError("AppleAuthProvider not implemented")
        }
    }
}


class MockAuthService: AuthServiceProtocol {
    var userSession: FirebaseAuth.User? = nil
    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> {
        Just(nil).eraseToAnyPublisher()
    }
    
    func login(withEmail email: String, password: String) async throws {
        print("Mock login called")
    }
    
    func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws {
        print("Mock createUser called")
    }
    
    func resetPassword(email: String) async throws {
        print("Mock resetPassword called")
    }
    
    func signOut() async throws {
        print("Mock signOut called")
    }
    
    func deleteUser() async throws {
        print("Mock deleteUser called")
    }
}
