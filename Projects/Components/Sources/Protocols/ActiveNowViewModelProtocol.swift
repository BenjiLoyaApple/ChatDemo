//
//  ActiveNowViewModelProtocol.swift
//  Components
//
//  Created by Benji Loya on 04.12.2024.
//

import Foundation

public protocol ActiveNowViewModelProtocol: ObservableObject {
    associatedtype UserType: UserRepresentable
    var users: [UserType] { get }
    var isLoading: Bool { get }
}
