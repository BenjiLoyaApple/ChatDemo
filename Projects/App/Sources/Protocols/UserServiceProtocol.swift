//
//  UserServiceProtocol.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation
import Firebase
//import Models

protocol UserServiceProtocol {
    var currentUser: User? { get set }
    
    func fetchCurrentUser() async throws -> User?
    static func fetchUser(uid: String) async throws -> User
    static func fetchUsers(limit: Int?) async throws -> [User]
    func updateUserProfileImageUrl(_ profileImageUrl: String) async throws
    func updateLastActive() async throws
}

//typealias AppUser = Models.User
//
//protocol UserServiceProtocol {
//    var currentUser: AppUser? { get set }
//    
//    func fetchCurrentUser() async throws -> AppUser?
//    static func fetchUser(uid: String) async throws -> AppUser
//    static func fetchUsers(limit: Int?) async throws -> [AppUser]
//    func updateUserProfileImageUrl(_ profileImageUrl: String) async throws
//    func updateLastActive() async throws
//}
