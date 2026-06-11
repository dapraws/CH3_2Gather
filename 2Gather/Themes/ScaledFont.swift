//
//  ScaledFont.swift
//  2Gather
//
//  Created by Andhika Satria on 10/06/26.
//

import SwiftUI

struct ScaledFontModifier: ViewModifier {
    @Environment(\.textSizeMultiplier) var multiplier
    let style: TGFontStyle

    func body(content: Content) -> some View {
        content.font(style.scaledFont(multiplier: multiplier))
    }
}

private struct TextSizeMultiplierKey: EnvironmentKey {
    static let defaultValue: CGFloat = 1.0
}

extension EnvironmentValues {
    var textSizeMultiplier: CGFloat {
        get { self[TextSizeMultiplierKey.self] }
        set { self[TextSizeMultiplierKey.self] = newValue }
    }
}

extension View {
    func scaledFont(_ style: TGFontStyle) -> some View {
        modifier(ScaledFontModifier(style: style))
    }
}
