//
//  MockProfile.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

public struct MockUser: Identifiable, UserRepresentable {
    public var id: String
    public var username: String
    public var profileImageUrl: String?
    
    public init(id: String, username: String, profileImageUrl: String? = nil) {
        self.id = id
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
}
