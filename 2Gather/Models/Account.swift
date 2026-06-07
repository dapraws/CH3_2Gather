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
    var username: String
    var password: String
    var preferenceSportIDs: [String]
    var createdAt: Date
    var profilePhoto: String?
    
    init(
        id: UUID = UUID(),
        email: String,
        username: String,
        password: String,
        preferenceSportIDs: [String] = [],
        createdAt: Date = .now,
        profilePhoto: String? = nil
    ) {
        self.id = id
        self.email = email
        self.username = username
        self.password = password
        self.preferenceSportIDs = preferenceSportIDs
        self.createdAt = createdAt
        self.profilePhoto = profilePhoto
    }
}
