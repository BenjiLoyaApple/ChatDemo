//
//  ChatMessgeCell.swift
//  ChatApp
//
//  Created by Benji Loya on 10.08.2023.
//

import SwiftUI
import Firebase

struct ChatMessageCell: View {
    let message: Message
    var nextMessage: Message?
    
    init(message: Message, nextMessage: Message?) {
        self.message = message
        self.nextMessage = nextMessage
    }
    
    var body: some View {
        HStack {
            if message.isFromCurrentUser {
                Spacer()
                messageContent
                    .padding(.horizontal)
            } else {
                HStack(alignment: .bottom, spacing: 8) {
                    if shouldShowChatPartnerImage {
                        CircularProfileImageView(user: message.user, size: .small28)
                    }
                    messageContent
                        .padding(.leading, shouldShowChatPartnerImage ? 0 : 32)
                }
                .padding(.horizontal, 15)
                Spacer()
            }
        }
    }
    
    private var shouldShowChatPartnerImage: Bool {
        if nextMessage == nil && !message.isFromCurrentUser { return true }
        guard let next = nextMessage else { return message.isFromCurrentUser }
        return next.isFromCurrentUser
    }
    
    private var messageContent: some View {
        switch message.contentType {
        case .image(let imageUrl):
            return AnyView(MessageImageView(imageUrlString: imageUrl))
        case .text(let messageText):
            return AnyView(Text(messageText)
                .font(.subheadline)
                .padding(12)
                .background(LinearGradient(colors: [
                    message.isFromCurrentUser ? .theme.primaryBlue : .theme.primaryGray2,
                    message.isFromCurrentUser ? .blue.opacity(0.9) : .theme.primaryGray
                ], startPoint: .leading, endPoint: .trailing))
                .foregroundColor(message.isFromCurrentUser ? .white : Color.theme.primaryText)
                .clipShape(ChatBubble(isFromCurrentUser: message.isFromCurrentUser, shouldRoundAllCorners: !message.isFromCurrentUser))
                .frame(maxWidth: UIScreen.main.bounds.width / (message.isFromCurrentUser ? 1.5 : 1.75), alignment: message.isFromCurrentUser ? .trailing : .leading)
            )
        case .link(let linkMetaData):
            return AnyView(LinkPreviewCell(linkMetaData: linkMetaData)
                .frame(maxWidth: UIScreen.main.bounds.width / (message.isFromCurrentUser ? 1.5 : 1.75), alignment: message.isFromCurrentUser ? .trailing : .leading)
            )
        }
    }
}

struct ChatMessageCell_Previews: PreviewProvider {
    static var previews: some View {
        let messages = DeveloperPreview.shared.messages
        
        VStack(spacing: 20) {
            ChatMessageCell(message: messages[0], nextMessage: messages[1])
                .previewLayout(.sizeThatFits)
            
            ChatMessageCell(message: messages[1], nextMessage: nil)
                .previewLayout(.sizeThatFits)
        }
    }
}
