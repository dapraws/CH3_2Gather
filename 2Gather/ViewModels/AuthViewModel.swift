//
//  AuthViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import Combine
import SwiftData
import SwiftUI

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var loginEmail: String = ""
    @Published var loginPassword: String = ""

    @Published var registerName: String = ""
    @Published var registerEmail: String = ""
    @Published var registerPassword: String = ""

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let authService: AuthService

    init(authService: AuthService) {
        self.authService = authService
    }

    @discardableResult
    func login(modelContext: ModelContext, session: AppSession) -> Bool {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let account = try authService.login(
                email: loginEmail.trimmingCharacters(in: .whitespacesAndNewlines),
                password: loginPassword,
                modelContext: modelContext
            )
            session.login(userId: account.id)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    @discardableResult
    func register(modelContext: ModelContext, session: AppSession) -> Bool {
        isLoading = true
        errorMessage = nil

        defer { isLoading = false }

        do {
            let account = try authService.register(
                name: registerName.trimmingCharacters(in: .whitespacesAndNewlines),
                email: registerEmail.trimmingCharacters(in: .whitespacesAndNewlines),
                password: registerPassword,
                modelContext: modelContext
            )
            session.login(userId: account.id)
            return true
        } catch {
            errorMessage = error.localizedDescription
            return false
        }
    }

    func clearMessages() {
        errorMessage = nil
    }
}
