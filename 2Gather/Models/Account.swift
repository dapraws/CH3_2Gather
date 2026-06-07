//
//  Account.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import SwiftData

@Model
final class Account {
    @Attribute(.unique) var id: UUID
    var email: String
    var name: String
    var password: String
    var preferenceSportIDs: [String]
    var createdAt: Date
    
    init(
        id: UUID = UUID(),
        email: String,
        name: String,
        password: String,
        preferenceSportIDs: [String] = [],
        createdAt: Date = .now
    ) {
        self.id = id
        self.email = email
        self.name = name
        self.password = password
        self.preferenceSportIDs = preferenceSportIDs
        self.createdAt = createdAt
    }
}
