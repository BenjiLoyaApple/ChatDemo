//
//  InboxServiceProtocol.swift
//  ChatApp
//
//  Created by Benji Loya on 10.11.2024.
//

import Foundation
import Firebase

protocol InboxServiceProtocol {
    func observeRecentMessagesStream() -> AsyncStream<[DocumentChange]>
    func deleteMessage(_ message: Message) async throws
    func reset()
}
