//
//  OffsetHelper.swift
//  TelegramDynamicIslandHeader
//
//  Created by Balaji on 28/05/23.
//

import SwiftUI

struct OffsetKeyProfile: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

extension View {
    @ViewBuilder
    func offsetExtractor(coordinateSpace: String, completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader {
                    let rect = $0.frame(in: .named(coordinateSpace))
                    Color.clear
                        .preference(key: OffsetKeyProfile.self, value: rect)
                        .onPreferenceChange(OffsetKeyProfile.self, perform: completion)
                }
            }
    }
}

struct OffsetHelper_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
