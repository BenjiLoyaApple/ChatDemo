//
//  MockActiveNowViewModel.swift
//  Components
//
//  Created by Benji Loya on 04.12.2024.
//

import Foundation

public class MockActiveNowViewModel: ObservableObject, ActiveNowViewModelProtocol {
    public typealias UserType = MockUser
    @Published public var users: [MockUser]
    @Published public var isLoading: Bool
    
    public init(users: [MockUser] = [], isLoading: Bool = false) {
        self.users = users
        self.isLoading = isLoading
    }
}
