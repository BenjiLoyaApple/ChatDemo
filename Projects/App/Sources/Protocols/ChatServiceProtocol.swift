//
//  ChatServiceProtocol.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation

protocol ChatServiceProtocol {
    var chatPartner: User { get }
    func observeMessages(completion: @escaping ([Message]) -> Void)
    func sendMessage(type: MessageSendType) async throws
    func updateMessageStatusIfNecessary(_ message: Message) async throws
    func removeListener()
}
