//
//  TGFontStyle.swift
//  2Gather
//
//  Created by Andhika Satria on 10/06/26.
//

import SwiftUI

enum TGFontStyle {
    // Display
    case displayXL, displayL, displayM
    // Heading
    case headingL, headingM, headingS, headingXXS
    // Body
    case bodyL, bodyM, bodyS, bodyXS
    // Label
    case labelXL, labelL, labelM, labelS
    // Special
    case filterChip
    
    var baseSize: CGFloat {
        switch self {
        case .displayXL:  return 64
        case .displayL:   return 48
        case .displayM:   return 30
        case .headingL:   return 24
        case .headingM:   return 20
        case .headingS:   return 17
        case .headingXXS: return 11
        case .bodyL:      return 17
        case .bodyM:      return 15
        case .bodyS:      return 13
        case .bodyXS:     return 11
        case .labelXL:    return 17
        case .labelL:     return 15
        case .labelM:     return 13
        case .labelS:     return 11
        case .filterChip: return 14
        }
    }
    
    var weight: Font.Weight {
        switch self {
        case .displayXL, .displayL:              return .black
        case .displayM:                          return .bold
        case .headingL:                          return .bold
        case .headingM, .headingS:               return .semibold
        case .headingXXS:                        return .bold    // sesuai Typography.swift
        case .bodyL, .bodyM, .bodyS, .bodyXS:    return .regular
        case .labelXL, .labelL, .labelM, .labelS,
                .filterChip:                        return .medium
        }
    }
    
    var design: Font.Design {
        switch self {
        case .displayXL, .displayL, .displayM: return .rounded
        default:                               return .default
        }
    }
    
    func scaledFont(multiplier: CGFloat) -> Font {
        .system(size: baseSize * multiplier, weight: weight, design: design)
    }
}
