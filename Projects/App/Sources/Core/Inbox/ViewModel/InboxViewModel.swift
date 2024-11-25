//
//  InboxViewModel.swift
//  ChatApp
//
//  Created by Benji Loya on 11.08.2023.
//

 import Foundation
 import Firebase
 import SwiftUI

 @MainActor
 class InboxViewModel: ObservableObject {
     @Published var recentMessages = [Message]()
     @Published var conversations = [Conversation]()
     @Published var user: User?
     @Published var searchText = ""
     var didCompleteInitialLoad = false

     var filteredMessages: [Message] {
         if searchText.isEmpty {
             return recentMessages
         } else {
             return recentMessages.filter { message in
                 guard let user = message.user else { return false }
                 return user.username.lowercased().contains(searchText.lowercased())
             }
         }
     }
     
     init() {
         Task {
             await setupUser()
             await observeRecentMessages()
         }
     }

     
     private func setupUser1() {
         user = UserService.shared.currentUser
     }
     
     private func setupUser() async {
         user = try? await UserService.shared.fetchCurrentUser()
     }

     
     func observeRecentMessages() async {
         for await changes in InboxService.shared.observeRecentMessagesStream() {
             if !didCompleteInitialLoad {
                 await loadInitialMessages(fromChanges: changes)
             } else {
                 await updateMessages(fromChanges: changes)
             }
         }
     }
     
     private func loadInitialMessages(fromChanges changes: [DocumentChange]) async {
         recentMessages = changes.compactMap { try? $0.document.data(as: Message.self) }
         
         await withTaskGroup(of: Void.self) { group in
             for i in recentMessages.indices {
                 group.addTask {
                     let message = await self.recentMessages[i]
                     let user = try? await UserService.fetchUser(uid: message.chatPartnerId)
                     await MainActor.run {
                         self.recentMessages[i].user = user
                         if i == self.recentMessages.count - 1 {
                             self.didCompleteInitialLoad = true
                         }
                     }
                 }
             }
         }
     }
     
     private func updateMessages(fromChanges changes: [DocumentChange]) async {
         for change in changes {
             if change.type == .added {
                 await createNewConversation(fromChange: change)
             } else if change.type == .modified {
                 await updateMessagesFromExistingConversation(fromChange: change)
             }
         }
     }
     
     private func createNewConversation(fromChange change: DocumentChange) async {
         guard var message = try? change.document.data(as: Message.self) else { return }
         message.user = try? await UserService.fetchUser(uid: message.chatPartnerId)
         await MainActor.run {
             recentMessages.insert(message, at: 0)
         }
     }
     
     private func updateMessagesFromExistingConversation(fromChange change: DocumentChange) async {
         guard var message = try? change.document.data(as: Message.self) else { return }
         guard let index = recentMessages.firstIndex(where: {
             $0.user?.id ?? "" == message.chatPartnerId
         }) else { return }
         message.user = recentMessages[index].user
         await MainActor.run {
             recentMessages.remove(at: index)
             recentMessages.insert(message, at: 0)
             
             if message.fromId != user?.id {
                 // Запуск уведомления о новом сообщении
             }
         }
     }
     
     func deleteMessage(_ message: Message) async throws {
         await MainActor.run {
             recentMessages.removeAll { $0.id == message.id }
         }
         try await InboxService.shared.deleteMessage(message)
     }

 }
