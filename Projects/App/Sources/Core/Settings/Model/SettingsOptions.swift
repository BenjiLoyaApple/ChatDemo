//
//  SettingsOptions.swift
//  Threads
//
//  Created by Benji Loya on 25.04.2023.
//

import Foundation

enum SettingsOptions: Int, CaseIterable, Identifiable {
    case notifications
    case privacy
    case account
    case colorTheme
    case help
    case about
    
    var title: String {
        switch self {
        case .notifications: return "Notifications"
        case .privacy: return "Privacy"
        case .account: return "Account"
        case .colorTheme: return "Theme"
        case .help: return "Help"
        case .about: return "About"
        }
    }
    
    var imageName: String {
        switch self {
        case .notifications: return "bell"
        case .privacy: return "lock"
        case .account: return "person"
        case .colorTheme: return "moon"
        case .help: return "questionmark.app"
        case .about: return "info.square"
        }
    }
    
    var id: Int { return self.rawValue }
}
