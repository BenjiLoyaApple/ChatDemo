//
//  HeaderView.swift
//  Components
//
//  Created by Benji Loya on 04.12.2024.
//

import SwiftUI

public struct HeaderComponent<Content: View>: View {
    
    public var backButtonPressed: (() -> Void)? = nil
    public let content: Content
    
    public init(
        backButtonPressed: (() -> Void)? = nil,
        @ViewBuilder content: () -> Content
    ) {
        self.backButtonPressed = backButtonPressed
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                CustomChatButton(
                    imageSource: .systemName("chevron.left"),
                    font: .title2,
                    foregroundColor: Color.primary,
                    padding: 5
                ) {
                    backButtonPressed?()
                }
                
                content
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 15)
            .padding(.vertical, 11)
            
            Divider()
                .opacity(0.6)
        }
    }
}

#Preview {
    HeaderComponent(backButtonPressed: {
        
    }) {
        Text("This is the content for the header view")
            .font(.body)
            .foregroundColor(.gray)
    }
}
