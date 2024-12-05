//
//  AuthManager.swift
//  ChatDemo
//
//  Created by alexander on 5.12.24.
//

import Foundation
//import FirebaseAuth
//
//struct AuthDataResultModel {
//    let uid: String
//    let email: String?
//    let photoUrl: String?
//    
//    init(user: User) {
//        self.uid = user.id
//        self.email = user.email
//        self.photoUrl = user.profileImageUrl
//    }
//}
//
//enum AuthProviderOption: String {
//    case email = "password"
//    case google = "google.com"
//    case apple = "apple.com"
//}
//
//final class AuthenticationManager {
//    
//    static let shared = AuthenticationManager()
//    
//    private init() { }
//    
//    // проверка пользователя происходит не асинхронно, потому что это происходит при загрузке приложения, то есть это нужно проверить первее
//    
////    func getAuthenticatedUser() throws -> AuthDataResultModel {
////        guard let user5 = Auth.auth().currentUser else {
////            throw URLError(.badServerResponse) }
////        
////        return AuthDataResultModel(user: user5)
////    }
//    
//    func getProvider() throws -> [AuthProviderOption] {
//        guard let providerData = Auth.auth().currentUser?.providerData else {
//            throw URLError(.badServerResponse)
//        }
//        
//        var providers: [AuthProviderOption] = []
//        for provider in providerData {
//            if let option = AuthProviderOption(rawValue: provider.providerID) {
//                providers.append(option)
//            } else {
//                assertionFailure("Provider option not found: \(provider.providerID)")
//            }
//            print(provider.providerID)
//        }
//        
//        return providers
//    }
//    
//    func signOut() throws {
//        try Auth.auth().signOut()
//    }
//}
