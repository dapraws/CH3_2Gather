//
//  SportPreferences.swift
//  2Gather
//
//  Created by Andhika Satria on 03/06/26.
//

import SwiftUI
import SwiftData
import Flow

struct PreferencesSettingsView: View {
    @EnvironmentObject private var session: AppSession
    @Environment(\.modelContext) private var modelContext
    @Query private var accounts: [Account]
    var vm: SettingsViewModel

    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }

    private var selectedSportIDs: Set<String> {
        Set(account?.preferenceSportIDs ?? [])
    }

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField("Search sports...", text: Binding(
                    get: { vm.searchText },
                    set: { vm.searchText = $0 }
                ))
                .autocorrectionDisabled(true)

                if !vm.searchText.isEmpty {
                    Button { vm.searchText = "" } label: {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if vm.filteredSports.isEmpty {
                        Text("No sports found.")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        HFlow {
                            ForEach(vm.filteredSports) { sport in
                                SportTag(
                                    sport: sport.name,
                                    isSelected: selectedSportIDs.contains(sport.id)
                                ) {
                                    vm.toggleSport(sport, account: account, modelContext: modelContext)
                                }
                            }
                        }
                    }

                    Image(.mascotBasketball)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationTitle("Sports Preferences")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        PreferencesSettingsView(vm: SettingsViewModel())
            .environmentObject(AppSession())
    }
}

