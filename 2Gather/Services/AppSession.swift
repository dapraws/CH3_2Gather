//
//  AppSession.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import Foundation
import SwiftUI
import Combine

final class AppSession: ObservableObject {
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding: Bool = false
    @AppStorage("loggedInUserEmail") var loggedInUserEmail: String = ""

    @Published var isLoggedIn: Bool = false

    init() {
        self.isLoggedIn = !loggedInUserEmail.isEmpty
    }

    func login(email: String) {
        loggedInUserEmail = email
        isLoggedIn = true
    }

    func logout() {
        loggedInUserEmail = ""
        isLoggedIn = false
    }

    func completeOnboarding() {
        hasCompletedOnboarding = true
    }
}
