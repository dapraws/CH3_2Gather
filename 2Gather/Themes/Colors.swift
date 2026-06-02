//
//  Colors.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 25/05/26.
//

import SwiftUI

// MARK: - Hex Helper

extension Color {
    init(hex: String) {
        var s = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if s.hasPrefix("#") { s.removeFirst() }
        var value: UInt64 = 0
        Scanner(string: s).scanHexInt64(&value)
        self.init(
            .sRGB,
            red:     Double((value >> 16) & 0xFF) / 255,
            green:   Double((value >>  8) & 0xFF) / 255,
            blue:    Double( value        & 0xFF) / 255,
            opacity: s.count == 8 ? Double(value & 0xFF) / 255 : 1.0
        )
    }
}

// MARK: - Design System Colors

extension Color {

    
    // MARK: Brand
    static let TGprimary   = Color(hex: "#301720")   // Brown
    static let TGsecondary = Color(hex: "#FF7606")   // Orange
    static let TGterniary    = Color(hex: "#FFDC49")   // Yellow

    // MARK: Background
    static let backgroundPrimary   = Color(.systemBackground)
    static let backgroundSecondary = Color(.secondarySystemBackground)
    static let backgroundElevated  = Color(.tertiarySystemBackground)

    // MARK: Text
    static let textPrimary   = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
    static let textDisabled  = Color(.tertiaryLabel)

    // MARK: Border
    static let borderDefault = Color(.separator)

    // MARK: Status
    static let success = Color(.systemGreen)
    static let warning = Color(.systemOrange)
    static let error   = Color(.systemRed)
    static let info    = Color(.systemBlue)

    // MARK: Sport
    static let scoreWin      = Color(.systemGreen)
    static let scoreLoss     = Color(.systemRed)
    static let scoreDraw     = Color(.systemGray)
    static let liveIndicator = Color(hex: "#FF3B30")
}
