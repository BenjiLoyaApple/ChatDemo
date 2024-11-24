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
         case .page1: "Welcome to chat"
         case .page2: "Connect with friends"
         case .page3: "Share Your Ideas"
         case .page4: "Build Your Network"
         }
     }
     
     var subTitle: String {
         switch self {
         case .page1: "We know how hard it is to be a developer. It\ndoesn’t have to be..."
         case .page2: "Personalized news feed, dev communities and\nsearch, much better than what’s out there."
         case .page3: "Post your own ideas and get feedback\n from others"
         case .page4: "The world's best chat platform\nfor staying up to date"
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
