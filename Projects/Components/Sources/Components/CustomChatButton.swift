//
//  CustomButton.swift
//  ChatApp
//
//  Created by Benji Loya on 02.09.2024.
//

import SwiftUI
/// Кнопка чата с кастомными параметрами.
public struct CustomChatButton: View {
    public enum ImageSource {
        case systemName(String) 
        case assetName(String)
    }

    // MARK: - Параметры кнопки
    private let imageSource: ImageSource?
    private let text: String?
    private let font: Font
    private let foregroundColor: Color
    private let padding: CGFloat
    private let frame: CGSize?
    private let onButtonPressed: () -> Void

    // MARK: - Инициализация
    public init(
        imageSource: ImageSource? = nil,
        text: String? = nil,
        font: Font = .title3,
        foregroundColor: Color = .primary,
        padding: CGFloat = 10,
        frame: CGSize? = nil,
        onButtonPressed: @escaping () -> Void = {}
    ) {
        self.imageSource = imageSource
        self.text = text
        self.font = font
        self.foregroundColor = foregroundColor
        self.padding = padding
        self.frame = frame
        self.onButtonPressed = onButtonPressed
    }

    // MARK: - Тело кнопки
    public var body: some View {
        Button(action: onButtonPressed) {
            HStack(spacing: 8) {
                if let imageSource = imageSource {
                    createImage(for: imageSource)
                }
                if let text = text, !text.isEmpty {
                    Text(text)
                        .font(font)
                        .foregroundColor(foregroundColor)
                }
            }
            .frame(width: frame?.width, height: frame?.height)
            .padding(padding)
            .background(Color.black.opacity(0.0001)) // Обеспечивает область нажатия
            .clipShape(Capsule())
        }
    }

    // MARK: - Вспомогательный метод для создания изображения
    @ViewBuilder
    private func createImage(for source: ImageSource) -> some View {
        switch source {
        case .systemName(let name):
            Image(systemName: name)
                .font(font)
                .foregroundColor(foregroundColor)
        case .assetName(let name):
            Image(name)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .foregroundColor(foregroundColor)
        }
    }
}

// MARK: - Превью для проверки компонента
#Preview {
    VStack(spacing: 16) {
        CustomChatButton(
            imageSource: .systemName("bell"),
            onButtonPressed: {
                print("Bell pressed!")
            }
        )
        
        CustomChatButton(
            imageSource: .systemName("moon"),
            font: .title,
            foregroundColor: .teal,
            padding: 20
        )
        
        CustomChatButton(
            text: "Done",
            foregroundColor: .purple
        )
    }
    .padding()
}
