//
//  ActiveNowViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 13.08.2023.
//

import Foundation

class ActiveNowViewModel: ObservableObject {
    @Published var users = [User]()
    @Published var isLoading = false
    
    private let fetchLimit = 20
    
    init() {
        Task {
            await fetchUsers()
        }
    }
    
    @MainActor
    func fetchUsers() async {
        isLoading = false
        do {
            self.users = try await UserService.fetchUsers(limit: fetchLimit)
            isLoading = true
        } catch {
            print("Ошибка при загрузке пользователей: \(error)")
            isLoading = false
        }
    }
}

