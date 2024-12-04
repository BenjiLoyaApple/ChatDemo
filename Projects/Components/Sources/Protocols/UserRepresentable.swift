//
//  ProfileRepresentable.swift
//  Components
//
//  Created by Benji Loya on 25.11.2024.
//

import Foundation

public protocol UserRepresentable {
    var username: String { get }
    var profileImageUrl: String? { get }
}
