//
//  HomeButtonView.swift
//  ios17
//
//  Created by Benji Loya on 06.09.2023.
//

import SwiftUI

struct LoginButtonView: View {
    var body: some View {
        CustomLoginButton(
            buttonTint: AnyShapeStyle(
                LinearGradient(
                    colors: [.red, .orange],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
        ) {
            HStack(spacing: 10) {
                Text("Login")
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
        }action: {
            try? await Task.sleep(for: .seconds(2))
            return .failed("Password Incorrect")
//            return .success
//            return.idle
        }
        .buttonStyle(.opacityLess)
    }
}

#Preview {
    LoginButtonView()
}
