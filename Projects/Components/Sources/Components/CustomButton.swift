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
    private let imageName2: String?
    private let imageForegroundColor: Color
    private let image2ForegroundColor: Color
    private let textForegroundColor: Color
    private let onButtonPressed: () -> Void
    
    // MARK: - Инициализация
    public init(
        imageName: String? = nil,
        title: LocalizedStringKey? = nil,
        imageName2: String? = nil,
        imageForegroundColor: Color = .primary,
        image2ForegroundColor: Color = .gray,
        textForegroundColor: Color = .primary,
        onButtonPressed: @escaping () -> Void = {}
    ) {
        self.imageName = imageName
        self.title = title
        self.imageName2 = imageName2
        self.imageForegroundColor = imageForegroundColor
        self.image2ForegroundColor = image2ForegroundColor
        self.textForegroundColor = textForegroundColor
        self.onButtonPressed = onButtonPressed
        
    }
    
    // MARK: - Тело кнопки
    public var body: some View {
        Button(action: onButtonPressed) {
            HStack(spacing: 15) {
                if let imageName = imageName {
                    Image(systemName: imageName)
//                        .font(.headline)
                        .font(.system(size: 21))
                        .foregroundColor(imageForegroundColor)
                }
                
                if let title = title {
                    Text(title)
                        .font(.system(size: 16))
                        .foregroundColor(textForegroundColor)
                }
                
                Spacer(minLength: 0)
                
                if let imageName2 = imageName2 {
                    Image(systemName: imageName2)
                        .font(.headline)
                        .fontWeight(.light)
                        .foregroundColor(image2ForegroundColor)
                        .padding(.trailing, 10)
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical, 6)
            .padding(.horizontal, 12)
            .background(
                Color.black.opacity(0.001)
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
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
            textForegroundColor: .red
        ) {
            print("Theme button pressed")
        }
        
        CustomButton(
            title: "Just Text Button",
            textForegroundColor: .purple
        ) {
            print("Text button pressed")
        }
        
        CustomButton(
            title: "Text",
            imageName2: "chevron.right",
            textForegroundColor: .blue
        ) {
            print("Text button pressed")
        }
        
    }
    .padding()
}
