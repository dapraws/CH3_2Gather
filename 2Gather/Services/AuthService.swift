//
//  AuthService.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftData
import SwiftUI

enum AuthError: LocalizedError {
    case emailAlreadyUsed
    case invalidCredentials
    case emptyFields

    var errorDescription: String? {
        switch self {
        case .emailAlreadyUsed:
            return "Email already used."
        case .invalidCredentials:
            return "Invalid credentials."
        case .emptyFields:
            return "Fill all the empty fields."
        }
    }
}

final class AuthService {
    func register(
        name: String,
        email: String,
        password: String,
        modelContext: ModelContext
    ) throws -> Account {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }

        let descriptor = FetchDescriptor<Account>(
            predicate: #Predicate { $0.email == email }
        )

        if (try modelContext.fetch(descriptor).first) != nil {
            throw AuthError.emailAlreadyUsed
        }

        let newAccount = Account(
            id: UUID(),
            email: email,
            name: name,
            password: password
        )

        modelContext.insert(newAccount)
        try modelContext.save()

        return newAccount
    }

    func login(
        email: String,
        password: String,
        modelContext: ModelContext
    ) throws -> Account {
        guard !email.isEmpty, !password.isEmpty else {
            throw AuthError.emptyFields
        }

        let descriptor = FetchDescriptor<Account>(
            predicate: #Predicate { account in
                account.email == email && account.password == password
            }
        )

        guard let account = try modelContext.fetch(descriptor).first else {
            throw AuthError.invalidCredentials
        }

        return account
    }
}
