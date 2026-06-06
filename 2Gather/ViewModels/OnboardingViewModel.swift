//
//  OnboardingViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import Combine

@MainActor
final class OnboardingViewModel: ObservableObject {

    enum Step {
        case welcoming
        case login
        case register
        case sportPreferences
        case permission
    }

    @Published var currentStep: Step = .welcoming
    @Published var selectedSports: Set<String> = []
    @Published var navigationHistory: [Step] = []

    let sports = SportsCatalog.all.map { $0.name }

    func goBack() {
        guard let previous = navigationHistory.popLast() else { return }
        currentStep = previous
    }

    func goToLogin() {
        navigationHistory.append(currentStep)
        currentStep = .login
    }

    func goToRegister() {
        navigationHistory.append(currentStep)
        currentStep = .register
    }

    func goToSportPreferences() {
        navigationHistory.append(currentStep)
        currentStep = .sportPreferences
    }

    func goToPermission() {
        navigationHistory.append(currentStep)
        currentStep = .permission
    }

    func toggleSport(_ sport: String) {
        if selectedSports.contains(sport) {
            selectedSports.remove(sport)
        } else {
            selectedSports.insert(sport)
        }
    }

    func selectedSportsArray() -> [String] {
        selectedSports.sorted()
    }
}
