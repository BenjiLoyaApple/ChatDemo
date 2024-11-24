//
//  MessageServiceProtocol.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Firebase

protocol MessageServiceProtocol {
    func updateMessageStatusIfNecessary(_ messages: [Message]) async throws
}
