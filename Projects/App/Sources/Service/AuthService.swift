//
//  AuthService.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth
import Combine

class AuthService: AuthServiceProtocol, ObservableObject {
    private let provider: AuthProviderProtocol
    @Published private var _userSession: FirebaseAuth.User?

    init(provider: AuthProviderProtocol) {
        self.provider = provider
        self._userSession = provider.userSession
    }

    var userSession: FirebaseAuth.User? {
        return _userSession
    }

    var userSessionPublisher: AnyPublisher<FirebaseAuth.User?, Never> {
        $_userSession.eraseToAnyPublisher()
    }

    func login(withEmail email: String, password: String) async throws {
        try await provider.signIn(email: email, password: password)
        _userSession = provider.userSession
    }

    func createUser(withEmail email: String, password: String, username: String, fullname: String?) async throws {
        try await provider.createUser(email: email, password: password, username: username, fullname: fullname)
        _userSession = provider.userSession
    }

    func signOut() async throws {
        try await provider.signOut()
        _userSession = nil
    }

    func deleteUser() async throws {
        try await provider.deleteUser()
        _userSession = nil
    }
}



class EmailAuthProvider: AuthProviderProtocol {
    @Published var userSession: FirebaseAuth.User?
    
    init() {
        self.userSession = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) async throws {
        let result = try await Auth.auth().signIn(withEmail: email, password: password)
        self.userSession = result.user
    }
    
    func createUser(email: String, password: String, username: String, fullname: String?) async throws {
        let result = try await Auth.auth().createUser(withEmail: email, password: password)
        self.userSession = result.user
        
        // Сохранение дополнительной информации о пользователе
        let user = result.user
        try await saveUserData(userId: user.uid, email: email, username: username, fullname: fullname)
    }

    private func saveUserData(userId: String, email: String, username: String, fullname: String?) async throws {
        let user = User(
            username: username,
            fullname: fullname ?? "", // `fullname` опционален
            email: email,
            profileImageUrl: nil
        )
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.UsersCollection.document(userId).setData(encodedUser)
    }

    func signOut() async throws {
        try Auth.auth().signOut()
        self.userSession = nil
    }
    
    func deleteUser() async throws {
        guard let currentUser = Auth.auth().currentUser else { return }
        try await currentUser.delete()
        self.userSession = nil
    }
}
