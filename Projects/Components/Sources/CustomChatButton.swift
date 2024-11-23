//
//  CustomButton.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI

public struct CustomChatButton: View { // public, чтобы быть доступным из других модулей
    public enum ImageSource {
        case systemName(String)
        case assetName(String)
    }

    public var imageName: ImageSource?
    public var text: String?
    public var font: Font? = .title3
    public var foregroundStyle: Color? = .primary
    public var padding: CGFloat? = 10
    public var frame: CGSize? = nil
    public var onButtonPressed: (() -> Void)? = nil

    public init(
        imageName: ImageSource? = nil,
        text: String? = nil,
        font: Font? = .title3,
        foregroundStyle: Color? = .primary,
        padding: CGFloat? = 10,
        frame: CGSize? = nil,
        onButtonPressed: (() -> Void)? = nil
    ) {
        self.imageName = imageName
        self.text = text
        self.font = font
        self.foregroundStyle = foregroundStyle
        self.padding = padding
        self.frame = frame
        self.onButtonPressed = onButtonPressed
    }

    public var body: some View {
        Button(action: {
            onButtonPressed?()
        }) {
            Group {
                if let imageSource = imageName {
                    switch imageSource {
                    case .systemName(let name):
                        Image(systemName: name)
                    case .assetName(let name):
                        Image(name)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fill)
                    }
                } else if let text = text, !text.isEmpty {
                    Text(text)
                }
            }
            .font(font)
            .foregroundStyle(foregroundStyle ?? .primary)
            .frame(width: frame?.width, height: frame?.height)
            .padding(padding ?? 10)
            .background(Color.black.opacity(0.0001))
            .clipShape(Capsule())
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomChatButton(
            imageName: .systemName("bell")
        )
        
        CustomChatButton(
            imageName: .systemName("moon"),
            font: .title,
            foregroundStyle: .teal,
            padding: 20
        )
        
        CustomChatButton(
            text: "Done",
            foregroundStyle: .purple
        )
    }
    .padding(.horizontal)
}

