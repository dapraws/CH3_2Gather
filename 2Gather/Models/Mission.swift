//
//  Mission.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation
import SwiftData

@Model
class Mission {
    @Attribute(.unique) var id: UUID
    var name: String
    var desc: String
    var type: MissionType
    var proofPath: String?
    var isCompleted: Bool
    var reward: String
    
    init(
        id: UUID = UUID(),
        name: String,
        desc: String,
        type: MissionType = .solo,
        reward: String
    ) {
        self.id = id
        self.name = name
        self.desc = desc
        self.type = type
        self.proofPath = nil
        self.isCompleted = false
        self.reward = reward
    }
}

enum MissionType: String, Codable {
    case solo
    case group
}
