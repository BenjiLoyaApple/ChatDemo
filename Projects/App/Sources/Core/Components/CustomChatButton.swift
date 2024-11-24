//
//  CustomButton.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI

struct CustomChatButton: View {
    enum ImageSource {
        case systemName(String)
        case assetName(String)
    }

    var imageName: ImageSource?
    var text: String?
    var font: Font? = .title3
    var foregroundStyle: Color? = .primary
    var padding: CGFloat? = 10
    var frame: CGSize? = nil
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
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
        
        CustomChatButton(
            imageName: .assetName("gallery"),  // Используйте здесь имя вашего изображения из ассетов
            font: .system(size: 10),
            foregroundStyle: .primary,
            padding: 10, 
            frame: CGSize(width: 25, height: 25),
            onButtonPressed: {
                // нажатие кнопки
            }
        )
    }
    .padding(.horizontal)
}

