//
//  Extensions.swift
//  MyThreads
//
//  Created by Benji Loya on 19.07.2024.
//

import SwiftUI

// MARK: Custom View Extensions for INBOX HEADER
// Offset Extensions
extension View{
    // MARK: Previou,Current Offset To Find the Direction Of Swipe
    @ViewBuilder
    func offsetY(completion: @escaping (CGFloat,CGFloat)->())->some View{
        self
            .modifier(OffsetHelper(onChange: completion))
    }
    
    // MARK: Safe Area
    func safeArea()->UIEdgeInsets{
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene else{return .zero}
        guard let safeArea = scene.windows.first?.safeAreaInsets else{return .zero}
        return safeArea
    }
}

// MARK: Offset Helper
struct OffsetHelper: ViewModifier{
    var onChange: (CGFloat,CGFloat)->()
    @State var currentOffset: CGFloat = 0
    @State var previousOffset: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader{proxy in
                    let minY = proxy.frame(in: .named("SCROLL")).minY
                    Color.clear
                        .preference(key: OffsetKeyHeader.self, value: minY)
                        .onPreferenceChange(OffsetKeyHeader.self) { value in
                            previousOffset = currentOffset
                            currentOffset = value
                            onChange(previousOffset,currentOffset)
                        }
                }
            }
    }
}

// MARK: Offset Key
struct OffsetKeyHeader: PreferenceKey{
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

// MARK: Bounds Preference Key For Identiying Height of The Header View
struct HeaderBoundsKey: PreferenceKey{
    static var defaultValue: Anchor<CGRect>?
    
    static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {
        value = nextValue()
    }
}

