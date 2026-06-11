//
//  Colors.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 25/05/26.
//

import SwiftUI

//// MARK: - Hex Helper
//
//extension Color {
//    init(hex: String) {
//        var s = hex.trimmingCharacters(in: .whitespacesAndNewlines)
//        if s.hasPrefix("#") { s.removeFirst() }
//        var value: UInt64 = 0
//        Scanner(string: s).scanHexInt64(&value)
//        self.init(
//            .sRGB,
//            red:     Double((value >> 16) & 0xFF) / 255,
//            green:   Double((value >>  8) & 0xFF) / 255,
//            blue:    Double( value        & 0xFF) / 255,
//            opacity: s.count == 8 ? Double(value & 0xFF) / 255 : 1.0
//        )
//    }
//}
//
//// MARK: - Design System Colors
//
//extension Color {
//
//    
//    // MARK: Brand
//    static let TGprimary   = Color(hex: "#301720")   // Brown
//    static let TGsecondary = Color(hex: "#FF7606")   // Orange
//    static let TGterniary    = Color(hex: "#FFDC49")   // Yellow
//    
//    /////////////////////////////////////////////////////////////
//    // MARK: Light
//    static let TGLprimary   = Color(hex: "#301720")   // Brown (light)
//    static let TGLsecondary = Color(hex: "#FF7606")   // Orange (light)
//    static let TGLterniary    = Color(hex: "#FFDC49")   // Yellow (light)
//    // MARK: Dark
//    static let TGDprimary   = Color(hex: "#301720")   // Brown (dark)
//    static let TGDsecondary = Color(hex: "#FF7606")   // Orange (dark)
//    static let TGDterniary    = Color(hex: "#FFDC49")   // Yellow (dark)
//    /////////////////////////////////////////////////////////////
//    
//    // MARK: Background
//    static let backgroundPrimary   = Color(.systemBackground)
//    static let backgroundSecondary = Color(.secondarySystemBackground)
//    static let backgroundElevated  = Color(.tertiarySystemBackground)
//
//    // MARK: Text
//    static let textPrimary   = Color(.label)
//    static let textSecondary = Color(.secondaryLabel)
//    static let textDisabled  = Color(.tertiaryLabel)
//
//    // MARK: Border
//    static let borderDefault = Color(.separator)
//
//    // MARK: Status
//    static let success = Color(.systemGreen)
//    static let warning = Color(.systemOrange)
//    static let error   = Color(.systemRed)
//    static let info    = Color(.systemBlue)
//    
//    //MARK: Temporal Colors
//    static let TGgradient =  Color(hex: "FFF080")
//    static let TGred = Color(hex: "B24A4A")
//    static let Luser = Color(hex: "FFD245")
//    
//}


// MARK: - Design System Colors
extension Color {
    
    // MARK: Custom Assets (Terkoneksi ke Assets.xcassets)
    static let TGBorder         = Color("TGBorder")
    static let TGBrown          = Color("TGBrown")
    static let TGBrownToOrange  = Color("TGBrownToOrange")
    static let TGBrownToWhite   = Color("TGBrownToWhite")
    static let TGBrownToYellow  = Color("TGBrownToYellow")
    static let TGFWhite         = Color("TGFWhite")
    static let TGFWhiteToDGreen = Color("TGFWhiteToDGreen")
    static let TGFWhiteToSGreen = Color("TGFWhiteToSGreen")
    static let TGGradient       = Color("TGGradient")
    static let TGMauve          = Color("TGMauve")
    static let TGMauveToGrey    = Color("TGMauveToGrey")
    static let TGOrange         = Color("TGOrange")
    static let TGPUser          = Color("TGPUser")
    static let TGRedToOrange    = Color("TGRedToOrange")
    static let TGSGreyToSGreen  = Color("TGSGreyToSGreen")
    static let TGWhite          = Color("TGWhite")
    static let TGWhiteToBrown   = Color("TGWhiteToBrown")
    static let TGWhiteToDGreen  = Color("TGWhiteToDGreen")
    static let TGWhiteToSGreen  = Color("TGWhiteToSGreen")
    static let TGYellow         = Color("TGYellow")
    static let TGYellowToBrown  = Color("TGYellowToBrown")
    static let TGYellowToDGreen = Color("TGYellowToDGreen")
    
    
    // MARK: Native Background Colors (Otomatis Dark Mode)
    static let backgroundPrimary   = Color(.systemBackground)
    static let backgroundSecondary = Color(.secondarySystemBackground)
    static let backgroundElevated  = Color(.tertiarySystemBackground)
    
    // MARK: Native Text Colors (Otomatis Dark Mode)
    static let textPrimary   = Color(.label)
    static let textSecondary = Color(.secondaryLabel)
    static let textDisabled  = Color(.tertiaryLabel)
    
    // MARK: Native Border Color (Otomatis Dark Mode)
    static let borderDefault = Color(.separator)
    
    // MARK: Native Status Colors (Otomatis Dark Mode)
    static let success = Color(.systemGreen)
    static let warning = Color(.systemOrange)
    static let error   = Color(.systemRed)
    static let info    = Color(.systemBlue)
}
