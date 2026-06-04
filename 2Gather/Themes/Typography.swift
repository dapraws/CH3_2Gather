//
//  Typography.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 25/05/26.
//

import SwiftUI

// MARK: - Typography Scale

extension Font {

    // MARK: Display
    static let displayXL: Font = .system(size: 64, weight: .black, design: .rounded)
    static let displayL:  Font = .system(size: 48, weight: .black, design: .rounded)
    static let displayM:  Font = .system(size: 30, weight: .bold,  design: .rounded)

    // MARK: Heading
    static let headingL: Font = .system(size: 24, weight: .bold)
    static let headingM: Font = .system(size: 20, weight: .semibold)
    static let headingS: Font = .system(size: 17, weight: .semibold)

    // MARK: Body
    static let bodyL:  Font = .system(size: 17, weight: .regular)
    static let bodyM:  Font = .system(size: 15, weight: .regular)
    static let bodyS:  Font = .system(size: 13, weight: .regular)
    static let bodyXS: Font = .system(size: 11, weight: .regular)

    // MARK: Label
    static let labelL: Font = .system(size: 15, weight: .medium)
    static let labelM: Font = .system(size: 13, weight: .medium)
    static let labelS: Font = .system(size: 11, weight: .medium)
    
    // MARK: Filter Chip
    static let TGfilterChipLabel: Font = .system(size: 17, weight: .medium)

}
