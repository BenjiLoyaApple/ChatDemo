//
//  SettingsOptions.swift
//  Threads
//
//  Created by Benji Loya on 25.04.2023.
//

import SwiftUI
import Components

// MARK: - SectionItem Model
struct SectionItem: Identifiable {
    let id = UUID()
    let icon: String? 
    let title: LocalizedStringKey
    let trailingIcon: String?
    let iconForegroundColor: Color
    let trailingIconForegroundColor: Color
    let textForegroundColor: Color
    let isDisabled: Bool
    let action: () -> Void

    init(
        icon: String? = nil,
        title: LocalizedStringKey,
        trailingIcon: String? = nil,
        iconForegroundColor: Color = .primary,
        trailingIconForegroundColor: Color = .gray,
        textForegroundColor: Color = .primary,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.icon = icon
        self.title = title
        self.trailingIcon = trailingIcon
        self.iconForegroundColor = iconForegroundColor
        self.trailingIconForegroundColor = trailingIconForegroundColor
        self.textForegroundColor = textForegroundColor
        self.isDisabled = isDisabled
        self.action = action
    }
}

// MARK: - SectionView Component
struct SectionView: View {
    let title: String
    let items: [SectionItem]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.leading, 12)
            
            ForEach(items) { item in
                CustomButton(
                    imageName: item.icon,
                    title: item.title,
                    imageName2: item.trailingIcon,
                    imageForegroundColor: item.iconForegroundColor,
                    image2ForegroundColor: item.trailingIconForegroundColor,
                    textForegroundColor: item.textForegroundColor
                ) {
                    item.action()
                }
                .disabled(item.isDisabled)
            }
        }
        .padding(.bottom, 4)
    }
}

// MARK: - DividerView
struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(maxWidth: .infinity)
            .frame(height: 4)
            .foregroundStyle(.gray.opacity(0.1))
    }
}
