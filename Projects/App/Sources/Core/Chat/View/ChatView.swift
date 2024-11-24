//
//  ChatView.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import SwiftfulRouting

struct ChatView: View {
    @Environment(\.router) var router
    @State private var messageText = ""
    @State private var isInitialLoad = false
    @StateObject var viewModel: ChatViewModel
    private let user: User
    private var thread: Thread?
    
    init(user: User) {
            self.user = user
            let chatService = DIContainer.shared.createChatService(chatPartner: user)
            self._viewModel = StateObject(wrappedValue: ChatViewModel(service: chatService))
        }
    
    var body: some View {
        VStack {
            HeaderView()
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.messages.indices, id: \.self) { index in
                            ChatMessageCell(message: viewModel.messages[index],
                                            nextMessage: viewModel.nextMessage(forIndex: index))
                                .id(viewModel.messages[index].id)
                        }
                    }
                    .padding(.vertical)
                    .padding(.bottom, 60)
                }
                .onChange(of: viewModel.messages) {_, newValue in
                    guard  let lastMessage = newValue.last else { return }
            
                    withAnimation(.spring()) {
                        proxy.scrollTo(lastMessage.id)
                    }
                }
            }
            .overlay(alignment: .bottom) {
                MessageInputView(messageText: $messageText, viewModel: viewModel)
                    .background(
                        Color.theme.igChatBG
                            .padding(.bottom, -320)
                            .offset(y: 25)
                    )
            }
            .scrollDismissesKeyboard(.interactively)
            .scrollIndicators(.hidden)
        }
        .navigationBarBackButtonHidden()
        .background(Color.theme.igChatBG)
        .onDisappear {
            viewModel.removeChatListener()
        }
        .onChange(of: viewModel.messages, perform: { _ in
            Task { try await viewModel.updateMessageStatusIfNecessary()}
        })
    }
    
    // MARK: - Header
    @ViewBuilder
    private func HeaderView() -> some View {
        VStack(spacing: 0) {
            HStack(alignment: .center, spacing: 20) {
                
                CustomChatButton(
                    imageName: .systemName("chevron.left"),
                    font: .title2,
                    foregroundStyle: Color.theme.primaryText,
                    padding: 5
                ) {
                    router.dismissScreen()
                }
                
                HStack(spacing: 15) {
                    CircularProfileImageView(user: user, size: .small34)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.username)
                            .font(.subheadline)
                            .foregroundStyle(.primary.opacity(0.7))
                        
                        if let lastActive = user.lastActive {
                            Text("Active \(lastActive.timestampString()) ago")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        } else {
                            Text("Inactive")
                                .font(.caption2)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                Spacer(minLength: 0)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 10)
            
            Divider()
                .offset(y: 8)
                .opacity(0.4)
        }
        .padding(.top, 10)
    }
    
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView(user: .mock)
    }
}
