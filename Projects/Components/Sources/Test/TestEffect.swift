//
//  TestEffect.swift
//  Components
//
//  Created by Benji Loya on 26.12.2024.
//

import SwiftUI

// MARK: Intro Model And Sample Intro's
struct Intro: Identifiable {
    var id: String = UUID().uuidString
    var systemImageName: String
    var title: String
    var subtitle: String
}

var intros: [Intro] = [
    .init(systemImageName: "message.badge.waveform.fill", title: "Hey there! Your new chat space", subtitle: "Chats, friends, and cool communities — all in one place."),
    .init(systemImageName: "bolt.horizontal.icloud.fill", title: "Stay connected anywhere", subtitle: "Messages, calls, and live updates — everything you need is here."),
    .init(systemImageName: "paperplane.fill", title: "Share freely, live worry-free", subtitle: "Share thoughts, photos, and videos with your friends in seconds."),
    .init(systemImageName: "globe.americas.fill", title: "Discover new friends worldwide", subtitle: "Join communities and stay on top of all the latest trends.")
]



import SwiftUI

struct TestEffect: View {
    /// Текущий индекс отображаемого изображения
    @State private var currentIndex: Int = 0
    
    var body: some View {
        VStack {
            MorphingSymbolView(
                symbol: intros[currentIndex].systemImageName,
                config: .init(
                    font: .system(size: 150, weight: .bold),
                    frame: .init(width: 250, height: 200),
                    radius: 30,
                    foregroundColor: .primary.opacity(0.7)
                )
            )
            
            Text(intros[currentIndex].title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 20)
            
            Text(intros[currentIndex].subtitle)
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Spacer()
            
            // Кнопка переключения
            Button(action: {
                // Переход на следующий элемент
                withAnimation(.easeInOut) {
                    currentIndex = (currentIndex + 1) % intros.count
                }
            }) {
                Text("Next")
                    .fontWeight(.semibold)
                    .padding(.horizontal, 40)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 40)
        }
        .padding()
    }
}

#Preview {
    TestEffect()
}
