//
//  ContentView.swift
//  ChatApp
//
//  Created by Benji Loya on 08.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct ContentView: View {
    @Environment(\.router) var router
    @StateObject var viewModel = ContentViewModel()
    
    ///Theme
    @AppStorage("userTheme") private var userTheme: Theme = .systemDefault
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    
    var body: some View {
        Group {
//            if viewModel.userSession != nil {
            if isAuthenticated {
                InboxView()
            } else {
                IntrosView()
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
