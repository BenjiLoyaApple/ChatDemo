//
//  TransparentBlurView.swift
//  NewNote
//
//  Created by Benji Loya on 18.02.2024.
//

import SwiftUI

import SwiftUI

public struct TransparentBlurView: UIViewRepresentable {
    public var removeAllFilters: Bool = false
    
    public init(removeAllFilters: Bool = false) {
        self.removeAllFilters = removeAllFilters
    }
    
    public func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        return view
    }
    
    public func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    /// Удаляем все фильтры, кроме размытия
                    backdropLayer.filters?.removeAll(where: { filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    }
}

#Preview {
    TransparentBlurView()
        .padding(15)
}

/*
 .background {
     TransparentBlurView(removeAllFilters: true)
         .blur(radius: 9, opaque: true)
         .background(.black.opacity(0.05))
 }
 */
