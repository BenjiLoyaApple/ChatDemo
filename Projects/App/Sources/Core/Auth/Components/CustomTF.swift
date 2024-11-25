//
//  CustomTF.swift
//  ChatApp
//
//  Created by Benji Loya on 31.08.2024.
//

import SwiftUI

// Custom TF
struct CustomTF: View {
    var hint: String
    @Binding var text: String
    var icon: String
    var isPassword: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8, content: {
            if isPassword {
                SecureField(hint, text: $text)
            } else {
                TextField(hint, text: $text)
            }
            
            Divider()
        })
        .overlay(alignment: .trailing) {
            Image(systemName: icon)
                .foregroundStyle(.gray)
                .offset(y: -4)
        }
    }
}

