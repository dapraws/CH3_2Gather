//
//  Sport.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import Foundation

struct Sport: Identifiable, Codable, Hashable {
    let id: String
    let icon: String
    let name: String
}

enum SportsCatalog {
    static let all: [Sport] = [
        Sport(id: "futsal", icon: "figure.soccer", name: "Futsal"),
        Sport(id: "badminton", icon: "figure.badminton", name: "Badminton"),
        Sport(id: "basketball", icon: "figure.basketball", name: "Basketball"),
        Sport(id: "running", icon: "figure.run", name: "Running"),
        Sport(id: "cycling", icon: "figure.outdoor.cycle", name: "Cycling"),
        Sport(id: "tennis", icon: "figure.tennis", name: "Tennis"),
        Sport(id: "volleyball", icon: "figure.volleyball", name: "Volleyball"),
        Sport(id: "swimming", icon: "figure.swim", name: "Swimming"),
        Sport(id: "hiking", icon: "figure.hiking", name: "Hiking"),
        Sport(id: "boxing", icon: "figure.boxing", name: "Boxing"),
        Sport(id: "dancing", icon: "figure.dance", name: "Dancing"),
        Sport(id: "pilates", icon: "figure.pilates", name: "Pilates"),
        Sport(id: "yoga", icon: "figure.yoga", name: "Yoga")
        
    ]
}
