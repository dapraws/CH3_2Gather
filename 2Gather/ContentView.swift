//
//  ContentView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 07/05/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var events: [Event]

    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(0)

            MapView()
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
                .tag(1)
        }
        .tint(.TGsecondary)
        .onAppear {
            seedDataIfNeeded()
        }
    }

    private func seedDataIfNeeded() {
        guard events.isEmpty else { return }
        for event in TempData.allEvents {
            modelContext.insert(event)
        }
    }
}

#Preview {
    ContentView()
}
