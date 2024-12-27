//
//  ContentViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

import Foundation
import Combine
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var user: User?
    @Published var userSession: FirebaseAuth.User?

    private var cancellables = Set<AnyCancellable>()
    private let authService: AuthServiceProtocol

    init(authService: AuthServiceProtocol = DIContainer.shared.authService) {
        self.authService = authService
        setupSubscribers()
    }

    private func setupSubscribers() {
        UserService.shared.$currentUser
            .receive(on: DispatchQueue.main)
            .sink { [weak self] user in
                self?.user = user
            }
            .store(in: &cancellables)

        authService.userSessionPublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] session in
                self?.userSession = session
            }
            .store(in: &cancellables)
    }
}
