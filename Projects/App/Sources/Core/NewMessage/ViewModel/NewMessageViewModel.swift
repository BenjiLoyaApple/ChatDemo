//
//  NewMessageViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import Foundation

class NewMessageViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var searchText = ""
    
    var filteredUsers: [User] {
        if searchText.isEmpty {
            return users
        } else {
            return users.filter({
                $0.username.lowercased().contains(searchText.lowercased())
            })
        }
    }
    
    init() {
        Task { try await fetchUsers() }
    }
    
    @MainActor
    func fetchUsers() async throws {
        self.users = try await UserService.fetchUsers()
    }
    
}
