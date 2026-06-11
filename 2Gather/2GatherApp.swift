//
//  CH3_Group13App.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 07/05/26.
//

import SwiftData
import SwiftUI

@main
struct TwoGatherApp: App {
    @StateObject private var session = AppSession()
    @StateObject private var textSizeManager = TextSizeManager.shared
    
    var body: some Scene {
        WindowGroup {
            Group {
                if session.hasCompletedOnboarding {
                    ContentView()
                } else {
                    OnboardingView()
                        .environmentObject(session)
                }
            }
            .environmentObject(session)
            .environment(\.textSizeMultiplier,
                            textSizeManager.currentScale.multiplier)
        }
        .modelContainer(for: [Account.self, Event.self, Mission.self, UserEventState.self])
    }
}
