//
//  InboxService.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

 import Foundation
 import Firebase

class InboxService: InboxServiceProtocol {
    static let shared: InboxServiceProtocol = InboxService()
     
     private var firestoreListener: ListenerRegistration?
     
     // Создаём асинхронный поток для наблюдения за изменениями сообщений
     func observeRecentMessagesStream() -> AsyncStream<[DocumentChange]> {
         return AsyncStream { continuation in
             guard let uid = Auth.auth().currentUser?.uid else {
                 continuation.finish()
                 return
             }
             
             let query = FirestoreConstants.MessagesCollection
                 .document(uid)
                 .collection("recent-messages")
                 .order(by: "timestamp", descending: true)
             
             self.firestoreListener = query.addSnapshotListener { snapshot, _ in
                 guard let changes = snapshot?.documentChanges.filter({
                     $0.type == .added || $0.type == .modified
                 }) else { return }
                 
                 continuation.yield(changes)
             }
             
             continuation.onTermination = { _ in
                 self.firestoreListener?.remove()
                 self.firestoreListener = nil
             }
         }
     }
     
      func deleteMessage(_ message: Message) async throws {
         guard let uid = Auth.auth().currentUser?.uid else { return }
         let chatPartnerId = message.chatPartnerId
         
         let snapshot = try await FirestoreConstants.MessagesCollection.document(uid).collection(chatPartnerId).getDocuments()
         
         await withThrowingTaskGroup(of: Void.self) { group in
             for doc in snapshot.documents {
                 group.addTask {
                     try await FirestoreConstants.MessagesCollection
                         .document(uid)
                         .collection(chatPartnerId)
                         .document(doc.documentID)
                         .delete()
                 }
             }
             
             group.addTask {
                 try await FirestoreConstants.MessagesCollection
                     .document(uid)
                     .collection("recent-messages")
                     .document(chatPartnerId)
                     .delete()
             }
         }
     }
     
     func reset() {
         self.firestoreListener?.remove()
         self.firestoreListener = nil
     }
 }
 
