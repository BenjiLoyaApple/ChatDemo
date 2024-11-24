//
//  OffsetKey.swift
//  SheetHeight
//
//  Created by Benji Loya on 09.08.2024.
//

import SwiftUI

struct OffsetKeyLogin: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
