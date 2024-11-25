//
//  ProfileRepresentable.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

public protocol ProfileRepresentable {
    var profileImageUrl: String? { get }
    var username: String { get }
}
