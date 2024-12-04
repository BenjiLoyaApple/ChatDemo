//
//  MockActiveNowViewModel.swift
//  Components
//
//  Created by Benji Loya on 04.12.2024.
//

import Foundation

// Моковая версия ActiveNowViewModel
//public class MockActiveNowViewModel: ObservableObject {
//    @Published public var users: [MockUser]
//    @Published public var isLoading: Bool = false
//    
//    public init() {
//        // Создаем несколько моковых пользователей
//        self.users = [
//            MockUser(id: "1", username: "John Doe", profileImageUrl: "https://example.com/profile1.jpg"),
//            MockUser(id: "2", username: "Jane Smith", profileImageUrl: "https://example.com/profile2.jpg"),
//            MockUser(id: "3", username: "Sam Brown", profileImageUrl: "https://example.com/profile3.jpg")
//        ]
//        self.isLoading = true
//    }
//}

public class MockActiveNowViewModel: ObservableObject, ActiveNowViewModelProtocol {
    public typealias UserType = MockUser
    @Published public var users: [MockUser]
    @Published public var isLoading: Bool
    
    public init(users: [MockUser] = [], isLoading: Bool = false) {
        self.users = users
        self.isLoading = isLoading
    }
}
