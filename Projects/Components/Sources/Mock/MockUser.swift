//
//  MockProfile.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

//public struct MockUser: UserRepresentable {
//    public var username: String
//    public var profileImageUrl: String?
//
//    public init(username: String, profileImageUrl: String? = nil) {
//        self.username = username
//        self.profileImageUrl = profileImageUrl
//    }
//}


// Моковая модель для пользователя
public struct MockUser: Identifiable, UserRepresentable {
    public var id: String?
    public var username: String
    public var profileImageUrl: String?
    
    public init(id: String? = nil, username: String, profileImageUrl: String? = nil) {
        self.id = id
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
}

// Моковая версия ActiveNowViewModel
public class MockActiveNowViewModel: ObservableObject {
    @Published public var users: [MockUser]
    @Published public var isLoading: Bool = false
    
    public init() {
        // Создаем несколько моковых пользователей
        self.users = [
            MockUser(id: "1", username: "John Doe", profileImageUrl: "https://example.com/profile1.jpg"),
            MockUser(id: "2", username: "Jane Smith", profileImageUrl: "https://example.com/profile2.jpg"),
            MockUser(id: "3", username: "Sam Brown", profileImageUrl: "https://example.com/profile3.jpg")
        ]
        self.isLoading = true
    }
}

public protocol ActiveNowViewModelProtocol: ObservableObject {
    associatedtype UserType: UserRepresentable
    var users: [UserType] { get }
    var isLoading: Bool { get }
}
