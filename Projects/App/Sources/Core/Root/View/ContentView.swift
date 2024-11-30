//
//  ContentView.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import SwiftfulRouting
import Components

struct ContentView: View {
    @Environment(\.router) var router
    
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                InboxView()
            } else {
                RootView(content: IntrosView())
            }
        }
        .preferredColorScheme(userTheme.colorScheme)
    }
}

#Preview {
    RouterView { _ in
        ContentView()
    }
}
