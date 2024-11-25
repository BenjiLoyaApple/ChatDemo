//
//  CustomProgressIndicatorStyle.swift
//  SocialCloud
//
//  Created by Benji Loya on 07.05.2024.
//

import SwiftUI

struct CustomProgressIndicatorStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .opacity(0.8)
                .frame(width: 60, height: 60)
            Circle()
                .trim(from: 0, to: CGFloat(configuration.fractionCompleted ?? 0.1))
                .stroke(Color.black, lineWidth: 2)
                .rotationEffect(.degrees(-90))
                .frame(width: 60, height: 60)
        }
    }
}
