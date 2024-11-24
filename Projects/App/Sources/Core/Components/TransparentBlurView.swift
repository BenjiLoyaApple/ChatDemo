//
//  TransparentBlurView.swift
//  NewNote
//
//  Created by Benji Loya on 18.02.2024.
//


import SwiftUI

struct TransparentBlurView: UIViewRepresentable {
    var removeAllFilters: Bool = false
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialLight))
        
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        DispatchQueue.main.async {
            if let backdropLayer = uiView.layer.sublayers?.first {
                if removeAllFilters {
                    backdropLayer.filters = []
                } else {
                    /// Removing All Expect Blur Filter
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
