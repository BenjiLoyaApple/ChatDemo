//
//  Route.swift
//  ChatApp
//
//  Created by Benji Loya on 13.08.2023.
//

import Foundation

enum Route: Hashable {
    case profile(User)
    case chatView(User)
}
