//
//  TextSizeManager.swift
//  2Gather
//
//  Created by Andhika Satria on 09/06/26.
//

import SwiftUI
import Combine 

enum FontScale: String, CaseIterable {
    case small  = "Small"
    case normal = "Normal"
    case large  = "Large"

    var multiplier: CGFloat {
        switch self {
        case .small:  return 0.75
        case .normal: return 1.0
        case .large:  return 1.25
        }
    }

    var index: Int {
        switch self {
        case .small:  return 0
        case .normal: return 1
        case .large:  return 2
        }
    }

    static func from(index: Int) -> FontScale {
        switch index {
        case 0: return .small
        case 2: return .large
        default: return .normal
        }
    }
}

class TextSizeManager: ObservableObject {
    static let shared = TextSizeManager()

    @Published var currentScale: FontScale {
        didSet {
            UserDefaults.standard.set(currentScale.rawValue, forKey: "selectedFontScale")
        }
    }

    init() {
        let saved = UserDefaults.standard.string(forKey: "selectedFontScale") ?? ""
        self.currentScale = FontScale(rawValue: saved) ?? .normal
    }

    func setScale(_ scale: FontScale) {
        currentScale = scale
    }

    func scaled(_ size: CGFloat) -> CGFloat {
        size * currentScale.multiplier
    }
}
