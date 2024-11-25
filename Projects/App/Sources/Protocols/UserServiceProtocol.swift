//
//  UserServiceProtocol.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation
import Firebase

protocol UserServiceProtocol {
    var currentUser: User? { get set }
    
    func fetchCurrentUser() async throws -> User?
    static func fetchUser(uid: String) async throws -> User
    static func fetchUsers(limit: Int?) async throws -> [User]
    func updateUserProfileImageUrl(_ profileImageUrl: String) async throws
    func updateLastActive() async throws
}
