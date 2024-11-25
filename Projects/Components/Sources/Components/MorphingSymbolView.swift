//
//  MorphingSymbolView.swift
//  ChatApp
//
//  Created by Benji Loya on 31.08.2024.
//

import SwiftUI

/// View для отображения Morphing-эффекта символов (SF Symbols).
public struct MorphingSymbolView: View {
    // Символ для отображения
    public var symbol: String
    public var config: Config
    
    /// Свойства View
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    public init(symbol: String, config: Config) {
        self.symbol = symbol
        self.config = config
    }
    
    public var body: some View {
        Canvas { ctx, size in
            // Добавление фильтра для визуального эффекта
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroundColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { _, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol.isEmpty else { return }
            displayingSymbol = symbol
        }
    }
    
    /// Вспомогательная View для анимации символов
    @ViewBuilder
    private func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { _, newValue in
                    if newValue.rounded() == config.radius {
                        // Анимация смены символа
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }
    }
    
    /// Конфигурация MorphingSymbolView
    public struct Config {
        public var font: Font
        public var frame: CGSize
        public var radius: CGFloat
        public var foregroundColor: Color
        public var keyFrameDuration: CGFloat = 0.4
        public var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
        
        public init(
            font: Font,
            frame: CGSize,
            radius: CGFloat,
            foregroundColor: Color,
            keyFrameDuration: CGFloat = 0.4,
            symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
        ) {
            self.font = font
            self.frame = frame
            self.radius = radius
            self.foregroundColor = foregroundColor
            self.keyFrameDuration = keyFrameDuration
            self.symbolAnimation = symbolAnimation
        }
    }
}

/*
import SwiftUI

/// Custom Symbol Morphing View
struct MorphingSymbolView: View {
    
    var symbol: String
    var config: Config
    /// View Properties
    @State private var trigger: Bool = false
    @State private var displayingSymbol: String = ""
    @State private var nextSymbol: String = ""
    
    var body: some View {
        Canvas { ctx, size in
            ctx.addFilter(.alphaThreshold(min: 0.4, color: config.foregroudColor))
            
            if let renderedImage = ctx.resolveSymbol(id: 0) {
                ctx.draw(renderedImage, at: CGPoint(x: size.width / 2, y: size.height / 2))
            }
        } symbols: {
            ImageView()
                .tag(0)
        }
        .frame(width: config.frame.width, height: config.frame.height)
        .onChange(of: symbol) { oldVaue, newValue in
            trigger.toggle()
            nextSymbol = newValue
        }
        .task {
            guard displayingSymbol == "" else { return }
            displayingSymbol = symbol
        }
    }
    
    @ViewBuilder
    func ImageView() -> some View {
        KeyframeAnimator(initialValue: CGFloat.zero, trigger: trigger) { radius in
            Image(systemName: displayingSymbol)
                .font(config.font)
                .blur(radius: radius)
                .frame(width: config.frame.width, height: config.frame.height)
                .onChange(of: radius) { oldVaue, newValue in
                    if newValue.rounded() == config.radius {
                        /// Animating Symbol Change
                        withAnimation(config.symbolAnimation) {
                            displayingSymbol = nextSymbol
                        }
                    }
                }
        } keyframes: { _ in
            CubicKeyframe(config.radius, duration: config.keyFrameDuration)
            CubicKeyframe(0, duration: config.keyFrameDuration)
        }
        
        
    }
    
    struct Config {
        var font: Font
        var frame: CGSize
        var radius: CGFloat
        var foregroudColor: Color
        var keyFrameDuration: CGFloat = 0.4
        var symbolAnimation: Animation = .smooth(duration: 0.5, extraBounce: 0)
    }
    
}
*/

#Preview {
    MorphingSymbolView(
        symbol: "gearshape.fill",
        config: .init(
            font: .system(size: 100, weight: .bold),
            frame: CGSize(width: 250, height: 200),
            radius: 15,
            foregroundColor: .black
        )
    )
}
