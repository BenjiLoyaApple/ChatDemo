//
//  Page.swift
//  ChatApp
//
//  Created by Benji Loya on 31.08.2024.
//

import SwiftUI

enum Page: String, CaseIterable {
    case page1 = "message.badge.waveform.fill"
    case page2 = "bolt.horizontal.icloud.fill"
    case page3 = "paperplane.fill"
    case page4 = "globe.americas.fill"
    
    var title: String {
        switch self {
        case .page1: return "Hey there! Your new chat space"
        case .page2: return "Stay connected anywhere"
        case .page3: return "Share freely, live worry-free"
        case .page4: return "Discover new friends worldwide"
        }
    }

    var subTitle: String {
        switch self {
        case .page1: return "Chats, friends, and cool communities — all in one place."
        case .page2: return "Messages, calls, and live updates — everything you need is here."
        case .page3: return "Share thoughts, photos, and videos with your friends in seconds."
        case .page4: return "Join communities and stay on top of all the latest trends."
        }
    }
    
    var index: CGFloat {
        switch self {
        case .page1: 0
        case .page2: 1
        case .page3: 2
        case .page4: 3
        }
    }
    
    /// Fetches the next page, if it's not the last page
    var nextPage: Page {
        let index = Int(self.index) + 1
        if index < 4 {
            return Page.allCases[index]
        }
        
        return self
    }
    
    /// Fetches the previous page, if it's not the first page
    var previousPage: Page {
        let index = Int(self.index) - 1
        if index >= 0 {
            return Page.allCases[index]
        }
        
        return self
    }
}
