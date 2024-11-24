//
//  User.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import FirebaseFirestoreSwift
import Foundation
import Firebase

struct User: Identifiable, Codable, Hashable {
    @DocumentID var userId: String?
    var username: String
    var fullname: String?
    let email: String
    var profileImageUrl: String?
    var bio: String?
    var link: String?
    var lastActive: Timestamp?
    var isOnline: Bool {
            guard let lastActiveDate = lastActive?.dateValue() else {
                return false // Если lastActive равен nil, считаем пользователя офлайн
            }
            let now = Date()
            let timeInterval = now.timeIntervalSince(lastActiveDate)
            return timeInterval < 1 * 60 // 1 мин в секундах
        }
    
    var id: String {
        return userId ?? UUID().uuidString
    }
    
//    var firstName: String {
//        let components = username.components(separatedBy: " ")
//        return components.first ?? username
//    }
}

extension User: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
