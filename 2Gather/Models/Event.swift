//
//  Event.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation
import SwiftData

@Model
class Event {
    @Attribute(.unique) var id: UUID
    var name: String
    var desc: String
    var venueName: String
    var host: String
    var category: [String]
    var date: Date
    var latitude: Double
    var longitude: Double
    var photoPath: String?
    @Relationship(deleteRule: .cascade) var mission: Mission

    init(
        id: UUID = UUID(),
        name: String,
        desc: String,
        venueName: String,
        host: String = "Anonymous",
        category: [String] = [],
        date: Date = Date(),
        latitude: Double,
        longitude: Double,
        photoPath: String? = nil,
        mission: Mission
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.venueName = venueName
        self.host = host
        self.category = category
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.photoPath = photoPath
        self.mission = mission
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "d MMM"
        return formatter.string(from: date)
    }

    var formattedTime: String {
        let formatter = DateFormatter()
        //formatter.dateStyle = .none
        //formatter.timeStyle = .medium
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
