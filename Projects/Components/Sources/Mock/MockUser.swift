//
//  MockUser.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

import Foundation

// Моковый пользователь
public struct MockUser {
    var userId: String
    var username: String
    var fullname: String?
    var email: String
    var profileImageUrl: String?
    var bio: String?
    var link: String?
    
    // Функция для получения имени пользователя
    public var displayName: String {
        return username
    }
}
