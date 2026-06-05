//
//  AuthService.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import Foundation
import SwiftData

final class AuthService {
    func register(
        email: String,
        fullName: String,
        password: String,
        preferences: [String],
        context: ModelContext
    ) throws {
        let descriptor = FetchDescriptor<Account>(
            predicate: #Predicate { $0.email == email }
        )
        
        let existing = try context.fetch(descriptor)
        guard existing.isEmpty else {
            throw AuthError.emailAlreadyUsed
        }
        
        let account = Account(
            email: email,
            fullName: fullName,
            password: password,
            preferenceSportIDs: preferences
        )
        
        context.insert(account)
        try context.save()
    }
    
    func login(
        email: String,
        password: String,
        context: ModelContext
    ) throws -> Account {
        let descriptor = FetchDescriptor<Account>(
            predicate: #Predicate { $0.email == email && $0.password == password }
        )
        
        guard let account = try context.fetch(descriptor).first else {
            throw AuthError.invalidCredentials
        }
        
        return account
    }
}

enum AuthError: LocalizedError {
    case emailAlreadyUsed
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .emailAlreadyUsed:
            return "Email sudah terdaftar"
        case .invalidCredentials:
            return "Email atau password salah"
        }
    }
}
