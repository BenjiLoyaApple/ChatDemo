//
//  Constants.swift
//  ChatApp
//
//  Created by Benji Loya on 12.08.2023.
//

import Foundation
import Firebase

struct FirestoreConstants {
    static let Root = Firestore.firestore()
    static let UsersCollection = Root.collection("users")
    static let MessagesCollection = Root.collection("messages")
}
