//
//  UserModel.swift
//  Models
//
//  Created by Benji Loya on 04.12.2024.
//

/*
import FirebaseFirestoreSwift
import Foundation
import Firebase
import Components

public struct User: Identifiable, Codable, Hashable, UserRepresentable {
    @DocumentID public var userId: String?
    public var username: String
    public var fullname: String?
    public let email: String
    public var profileImageUrl: String?
    public var bio: String?
    public var link: String?
    public var lastActive: Timestamp?
    
    public var isOnline: Bool {
        guard let lastActiveDate = lastActive?.dateValue() else {
            return false // Если lastActive равен nil, считаем пользователя офлайн
        }
        let now = Date()
        let timeInterval = now.timeIntervalSince(lastActiveDate)
        return timeInterval < 1 * 60 // 1 мин в секундах
    }
    
    public var id: String {
        return userId ?? UUID().uuidString
    }
    
    public init(userId: String? = nil,
                username: String,
                fullname: String? = nil,
                email: String,
                profileImageUrl: String? = nil,
                bio: String? = nil,
                link: String? = nil,
                lastActive: Timestamp? = nil) {
        self.userId = userId
        self.username = username
        self.fullname = fullname
        self.email = email
        self.profileImageUrl = profileImageUrl
        self.bio = bio
        self.link = link
        self.lastActive = lastActive
    }
}

extension User: Equatable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
*/
