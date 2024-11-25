//
//  ShimmerEffect.swift
//  SocialCloud
//
//  Created by Benji Loya on 05.05.2024.
//

import SwiftUI

/// Расширение для `View`, добавляющее shimmer-эффект
public extension View {
    @ViewBuilder
    func shimmer(_ config: ShimmerConfig) -> some View {
        self.modifier(ShimmerEffectHelper(config: config))
    }
}

/// Конфигурация для shimmer-эффекта
public struct ShimmerConfig {
    public var tint: Color
    public var highlight: Color
    public var blur: CGFloat = 0
    public var highlightOpacity: CGFloat = 1
    public var speed: CGFloat = 2
    
    /// Публичный инициализатор
    public init(tint: Color, highlight: Color, blur: CGFloat = 0, highlightOpacity: CGFloat = 1, speed: CGFloat = 2) {
        self.tint = tint
        self.highlight = highlight
        self.blur = blur
        self.highlightOpacity = highlightOpacity
        self.speed = speed
    }
}

/// Вспомогательная структура для добавления shimmer-эффекта
fileprivate struct ShimmerEffectHelper: ViewModifier {
    public var config: ShimmerConfig
    
    /// Анимационные параметры
    @State private var moveTo: CGFloat = -0.7
    
    public func body(content: Content) -> some View {
        content
            .hidden() // Прячем оригинальное содержимое
            .overlay {
                /// Анимированное перекрытие
                Rectangle()
                    .fill(config.tint)
                    .mask {
                        content
                    }
                    .overlay {
                        /// Анимация свечения
                        GeometryReader { geometry in
                            let size = geometry.size
                            let extraOffset = size.height / 2.5
                            
                            Rectangle()
                                .fill(config.highlight)
                                .mask {
                                    Rectangle()
                                        .fill(
                                            LinearGradient(
                                                colors: [
                                                    .white.opacity(0),
                                                    config.highlight.opacity(config.highlightOpacity),
                                                    .white.opacity(0)
                                                ],
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .blur(radius: config.blur)
                                        .rotationEffect(.init(degrees: -70)) // Поворот угла свечения
                                        .offset(x: moveTo > 0 ? extraOffset : -extraOffset)
                                        .offset(x: size.width * moveTo)
                                }
                        }
                        .mask {
                            content
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.async {
                            moveTo = 0.7
                        }
                    }
                    .animation(.linear(duration: config.speed).repeatForever(autoreverses: false), value: moveTo)
            }
    }
}


/*
 .shimmer(.init(tint: .white.opacity(0.5), highlight: .white, blur: 5))
 */
