//
//  TempData.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation

struct TempData {
    
    // Missions
    
    static let soloMission1 = Mission(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000101")!,
        name: "Snap the Spike",
        desc: "Take a photo of someone spiking the ball during a match.",
        type: .solo,
        reward: "🏐 Nice shot! You captured the energy of the game!"
    )
    
    static let completedMission: Mission = {
        let m = Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000102")!,
            name: "Finish Line Proof",
            desc: "Take a photo at the finish line banner when you complete the run.",
            type: .solo,
            reward: "🏅 That's what we call a finisher!"
        )
        m.isCompleted = true
        return m
    }()
    
    // Events
    
    static let event1 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
        name: "Bali Beach Volleyball Open",
        desc: "Open to all skill levels. Come play, cheer, and soak up the sun.",
        venueName: "Kuta Beach Court",
        host: "Made Surya",
        category: ["volleyball", "beach", "outdoor"],
        date: Date().addingTimeInterval(86400),
        latitude: -8.7184,
        longitude: 115.1686,
        photoPath: "volleyball-bali",
        mission: soloMission1
    )
    
    static let event2 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000002")!,
        name: "Sunset Run",
        desc: "A casual sunset run along the Kuta Beach promenade.",
        venueName: "Pantai Jerman",
        host: "command run",
        category: ["running", "outdoor", "casual"],
        date: Date().addingTimeInterval(172800),
        latitude: -8.734574575259003,
        longitude: 115.16339702588904,
        photoPath: "run-bali",
        mission: completedMission
    )
    
    static let event3 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000003")!,
        name: "Legian Football Kickabout",
        desc: "A relaxed, friendly football session at Legian Street Field. No experience needed.",
        venueName: "Legian Street Field",
        host: "Budi Kick",
        category: ["football", "outdoor", "casual"],
        date: Date().addingTimeInterval(259200),
        latitude: -8.7080,
        longitude: 115.1670,
        photoPath: "football-bali",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000103")!,
            name: "First Touch",
            desc: "Take a photo of yourself on the pitch before the match starts.",
            type: .solo,
            reward: "⚽ The game begins with you!"
        )
    )
    
    static let event4 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000004")!,
        name: "Kuta Basketball Street Jam",
        desc: "Show up, run some plays, and make some noise.",
        venueName: "Kuta Sports Complex",
        host: "Darrel Hoops",
        category: ["basketball", "outdoor", "street"],
        date: Date().addingTimeInterval(345600),
        latitude: -8.7195,
        longitude: 115.1710,
        photoPath: "basket-bali",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000104")!,
            name: "Court Arrival",
            desc: "Take a photo of yourself at the basketball court before the game.",
            type: .solo,
            reward: "🏀 You showed up!"
        )
    )
    
    static let event5 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000005")!,
        name: "Kuta Cycling Morning Ride",
        desc: "Enjoy the quiet roads, cool breeze, and stunning sunrise views.",
        venueName: "Kuta Beach Start Point",
        host: "Pedal Bali",
        category: ["cycling", "outdoor", "morning"],
        date: Date().addingTimeInterval(432000),
        latitude: -8.7160,
        longitude: 115.1695,
        photoPath: "cycling-bali",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000105")!,
            name: "Sunrise Proof",
            desc: "Take a photo of the sunrise during your ride.",
            type: .solo,
            reward: "🌅 Early bird gets the view!"
        )
    )
    
    static let event6 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000006")!,
        name: "Arjuna Futsal Night",
        desc: "A fast-paced indoor futsal night at Arjuna Arena.",
        venueName: "Arjuna Indoor Arena",
        host: "Arjuna FC",
        category: ["football", "indoor", "night"],
        date: Date().addingTimeInterval(518400),
        latitude: -8.727050637638651,
        longitude: 115.17908040547496,
        photoPath: "futsal-bali",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000106")!,
            name: "Team Photo",
            desc: "Take a group photo with your team before the match.",
            type: .solo,
            reward: "📷 Squad goals captured!"
        )
    )
    
    static let event7 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000007")!,
        name: "Sunset Yoga at Seminyak",
        desc: "Wind down with a gentle yoga flow as the sun sets over the ocean. All levels welcome.",
        venueName: "Seminyak Beach Garden",
        host: "Ayu Wellness",
        category: ["outdoor", "yoga"],
        date: Date().addingTimeInterval(604800),
        latitude: -8.6910,
        longitude: 115.1560,
        photoPath: "yoga-bali",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000107")!,
            name: "Zen Moment",
            desc: "Take a photo of yourself in your favourite pose with the sunset behind you.",
            type: .solo,
            reward: "🧘 Inner peace unlocked!"
        )
    )
    
    static let event8 = Event(
        id: UUID(uuidString: "00000000-0000-0000-0000-000000000008")!,
        name: "Kuta Latin Dance Social",
        desc: "Salsa, bachata, and good vibes. No partner needed — just show up and move!",
        venueName: "Kuta Community Hall",
        host: "Ritmo Bali",
        category: ["indoor", "dancing"],
        date: Date().addingTimeInterval(691200),
        latitude: -8.737067123211615,
        longitude: 115.17565970508035,
        photoPath: "latin-dance",
        mission: Mission(
            id: UUID(uuidString: "00000000-0000-0000-0000-000000000108")!,
            name: "Dance Floor Proof",
            desc: "Snap a photo or short video of yourself dancing with someone new.",
            type: .solo,
            reward: "💃 You've got the rhythm!"
        )
    )
    
    static let allEvents: [Event] = [
        event1, event2, event3, event4, event5, event6, event7, event8,
    ]
}
