//
//  SettingsButton.swift
//  MyThreads
//
//  Created by Benji Loya on 18.08.2024.
//

import SwiftUI

struct CustomButton: View {
    
    var imageName: String?
    var title: String?
    var imageForegroundStyle: Color? = .primary
    var textForegroundStyle: Color? = .primary
    var onButtonPressed: (() -> Void)? = nil
    
    var body: some View {
        Button(action: {
            onButtonPressed?()
        }) {
            HStack(spacing: 15) {
                Image(systemName: imageName ?? "")
                    .font(.subheadline)
                    .foregroundStyle(imageForegroundStyle ?? .primary)
                
                Text(title ?? "")
                    .font(.subheadline)
                    .foregroundStyle(textForegroundStyle ?? .primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(5)
            .background(Color.black.opacity(0.001))
        }
        .foregroundColor(.primary)
    }
}

#Preview {
    VStack(spacing: 10) {
        CustomButton(
            imageName: "bell",
            title: "Notifications"
        )
        
        CustomButton(
            imageName: "moon", 
            title: "Theme",
            imageForegroundStyle: .teal,
            textForegroundStyle: .cyan
        )
    }
    .padding(.horizontal)
}
