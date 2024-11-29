//
//  SettingsButton.swift
//  MyThreads
//
//  Created by Benji Loya on 18.08.2024.
//

import SwiftUI

/// Кастомная кнопка с иконкой и текстом.
public struct CustomButton: View {
    
    // MARK: - Параметры кнопки
    private let imageName: String?
    private let title: LocalizedStringKey?
    private let imageForegroundColor: Color
    private let textForegroundColor: Color
    private let onButtonPressed: () -> Void
    
    // MARK: - Инициализация
    public init(
        imageName: String? = nil,
        title: LocalizedStringKey? = nil,
        imageForegroundColor: Color = .primary,
        textForegroundColor: Color = .primary,
        onButtonPressed: @escaping () -> Void = {}
    ) {
        self.imageName = imageName
        self.title = title
        self.imageForegroundColor = imageForegroundColor
        self.textForegroundColor = textForegroundColor
        self.onButtonPressed = onButtonPressed
    }
    
    // MARK: - Тело кнопки
    public var body: some View {
        Button(action: onButtonPressed) {
            HStack(spacing: 15) {
                if let imageName = imageName {
                    Image(systemName: imageName)
                        .font(.headline)
                        .foregroundColor(imageForegroundColor)
                }
                
                if let title = title {
                    Text(title)
                        .font(.callout)
                        .foregroundColor(textForegroundColor)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(
                Color.black.opacity(0.001) // Увеличиваем область нажатия
            )
            .contentShape(Rectangle()) // Обеспечиваем корректное нажатие
        }
        .buttonStyle(.plain) // Убираем дефолтный стиль кнопки
    }
}

// MARK: - Превью
#Preview {
    VStack(spacing: 10) {
        CustomButton(
            imageName: "bell",
            title: "Notifications"
        ) {
            print("Notifications button pressed")
        }
        
        CustomButton(
            imageName: "moon",
            title: "Theme",
            imageForegroundColor: .teal,
            textForegroundColor: .cyan
        ) {
            print("Theme button pressed")
        }
        
        CustomButton(
            title: "Just Text Button",
            textForegroundColor: .purple
        ) {
            print("Text button pressed")
        }
    }
    .padding()
}
