//
//  HeaderView.swift
//  Components
//
//  Created by Benji Loya on 04.12.2024.
//

import SwiftUI

public struct HeaderComponent<Content: View>: View {
    public var backButtonPressed: (() -> Void)? = nil
    public var buttonText: String? = nil
    public var buttonImageSource: CustomChatButton.ImageSource? = nil
    public var font: Font
    public let content: Content
    
    public init(
        backButtonPressed: (() -> Void)? = nil,
        buttonText: String? = nil,
        buttonImageSource: CustomChatButton.ImageSource? = nil,
        font: Font = .title2,
        @ViewBuilder content: () -> Content
    ) {
        self.backButtonPressed = backButtonPressed
        self.buttonText = buttonText
        self.buttonImageSource = buttonImageSource
        self.font = font
        self.content = content()
    }

    public var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                CustomChatButton(
                    imageSource: buttonImageSource,
                    text: buttonText,
                    font: font,
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
    VStack(spacing: 16) {
        // Использование только изображения
        HeaderComponent(
            backButtonPressed: {
                print("Back pressed")
            },
            buttonImageSource: .systemName("chevron.left")
        ) {
            Text("Header with Default Button")
                .font(.body)
        }
        
        // Использование только текста
        HeaderComponent(
            backButtonPressed: {
                print("Back pressed")
            },
            buttonText: "Close",
            font: .subheadline
        ) {
            Text("Header with Text Button")
                .font(.body)
        }
        
        // Использование одновременно текста и изображения
        HeaderComponent(
            backButtonPressed: {
                print("Back pressed")
            },
            buttonText: "Close",
            buttonImageSource: .systemName("chevron.left")
        ) {
            Text("Header with Both Button Elements")
                .font(.body)
        }
        
        // Без кнопки
        HeaderComponent {
            Text("Header without Button")
                .font(.body)
        }
    }
}
