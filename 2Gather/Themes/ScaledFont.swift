//
//  ScaledFont.swift
//  2Gather
//
//  Created by Andhika Satria on 10/06/26.
//

import SwiftUI

struct ScaledFontModifier: ViewModifier {
    @EnvironmentObject var textSizeManager: TextSizeManager
    let style: TGFontStyle

    func body(content: Content) -> some View {
        content.font(
            style.scaledFont(
                multiplier: textSizeManager.currentScale.multiplier
            )
        )
    }
}

extension View {
    func scaledFont(_ style: TGFontStyle) -> some View {
        modifier(ScaledFontModifier(style: style))
    }
}
