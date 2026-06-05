//
//  Account.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import Foundation
import SwiftData

@Model
final class Account {
    var email: String
    var fullName: String
    var password: String
    var preferenceSportIDs: [String]
    var createdAt: Date
    
    init(
        email: String,
        fullName: String,
        password: String,
        preferenceSportIDs: [String] = [],
        createdAt: Date = .now
    ) {
        self.email = email
        self.fullName = fullName
        self.password = password
        self.preferenceSportIDs = preferenceSportIDs
        self.createdAt = createdAt
    }
}
