//
//  DIContainer.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation

class DIContainer {
    
    static let shared = DIContainer()
    
    private init() { }
    
    lazy var inboxService: InboxServiceProtocol = InboxService.shared
    lazy var messageService: MessageServiceProtocol = MessageService()
    lazy var userService: UserServiceProtocol = UserService.shared
    
    // Фабрика для создания экземпляра ChatService с указанным партнером
    func createChatService(chatPartner: User) -> ChatServiceProtocol {
        return ChatService(chatPartner: chatPartner)
    }
    
    private let authProviderType: AuthProviderType = .email

       lazy var authService: AuthServiceProtocol = {
           let provider = AuthProviderFactory.createProvider(type: authProviderType)
           return AuthService(provider: provider)
       }()
}
