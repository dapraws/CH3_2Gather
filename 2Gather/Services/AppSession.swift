//
//  AppSession.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import Combine

final class AppSession: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    @AppStorage("loggedInUserId") var loggedInUserId: String = ""
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false

    func login(userId: UUID) {
        loggedInUserId = userId.uuidString
        isLoggedIn = true
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }

    func logout() {
        loggedInUserId = ""
        isLoggedIn = false
    }

    func resetOnboarding() {
        hasCompletedOnboarding = false
    }
}
