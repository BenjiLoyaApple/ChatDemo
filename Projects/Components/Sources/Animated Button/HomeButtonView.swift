//
//  HomeButtonView.swift
//  ios17
//
//  Created by Benji Loya on 06.09.2023.
//

import SwiftUI

struct HomeButtonView: View {
    var body: some View {
        CustomLoginButton(buttonTint: .blue) {
            HStack(spacing: 10) {
                Text("Login")
              //  Image(systemName: "chevron.right")
            }
            .fontWeight(.bold)
            .foregroundStyle(.white)
        }action: {
            try? await Task.sleep(for: .seconds(2))
            return .failed("Password Incorrect")
          //  return .success
        }
        .buttonStyle(.opacityLess)
     //  .preferredColorScheme(.dark)
    }
}

#Preview {
    HomeButtonView()
}
