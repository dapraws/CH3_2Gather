//
//  SettingsViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import Combine

enum AppAppearance: String, CaseIterable {
    case system
    case light
    case dark
}

final class SettingsViewModel: ObservableObject {
    @AppStorage("appAppearance") private var appAppearanceRawValue: String = AppAppearance.system.rawValue

    var selectedAppearance: AppAppearance {
        get { AppAppearance(rawValue: appAppearanceRawValue) ?? .system }
        set { appAppearanceRawValue = newValue.rawValue }
    }

    func setAppearance(_ appearance: AppAppearance) {
        selectedAppearance = appearance
    }
}
