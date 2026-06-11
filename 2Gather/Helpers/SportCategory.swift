//
//  SportCategory.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 25/05/26.
//

import SwiftUI

enum SportCategory: String, CaseIterable {
    case volleyball = "volleyball"
    case running = "running"
    case football = "football"
    case basketball = "basketball"
    case cycling = "cycling"
    case dancing = "dancing"
    case yoga = "yoga"
    case other = "other"
    
    var label: String {
        switch self {
        case .volleyball: return "Volleyball"
        case .running: return "Running"
        case .football: return "Football"
        case .basketball: return "Basketball"
        case .cycling: return "Cycling"
        case .dancing: return "Dancing"
        case .yoga: return "Yoga"
        case .other: return "Other"
        }
    }
    
    var icon: String {
        switch self {
        case .volleyball: return "figure.volleyball"
        case .running: return "figure.run"
        case .football: return "figure.soccer"
        case .basketball: return "figure.basketball"
        case .cycling: return "figure.outdoor.cycle"
        case .dancing: return "figure.socialdance"
        case .yoga: return "figure.yoga"
        case .other: return "figure.mixed.cardio"
        }
    }
    
    var color: Color {
        switch self {
        case .volleyball: return .orange
        case .running: return .green
        case .football: return .blue
        case .basketball: return .red
        case .cycling: return .purple
        case .dancing: return .pink
        case .yoga: return .yellow
        case .other: return .gray
        }
    }
    
    // Helper: given a category [String] from Event,
    // returns the first matching SportCategory it finds
    // If none match, returns .other
    static func from(categories: [String]) -> SportCategory {
        for raw in categories {
            if let match = SportCategory(rawValue: raw) {
                return match
            }
        }
        return .other
    }
}
