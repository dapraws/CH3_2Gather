//
//  SettingsView.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftData
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var session: AppSession
    @Environment(\.modelContext) private var modelContext
    @Query private var accounts: [Account]
    @State private var vm = SettingsViewModel()

    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: ProfileSettingsView(vm: vm)) {
                        HStack(spacing: 16) {
                            if let image = vm.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 78, height: 78)
                                    .clipShape(Circle())
                            } else {
                                Image(.mascotProfile)
                                    .resizable()
                                    .frame(width: 78, height: 78)
                                    .clipShape(Circle())
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text(account?.username ?? "2Gather")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                Text(account?.email ?? "Together, We are fit!")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }

                Section(
                    header: Text("Display & Appearance").textCase(.none).font(
                        .subheadline
                    )
                ) {
                    NavigationLink(destination: TextSizeView()) {
                        HStack(spacing: 16) {
                            HStack(alignment: .lastTextBaseline, spacing: 2) {
                                Text("A").font(
                                    .system(size: 15, weight: .medium)
                                )
                                Text("A").font(
                                    .system(size: 20, weight: .medium)
                                )
                            }
                            .frame(width: 28, alignment: .center)
                            Text("Text Size")
                        }
                    }

                    HStack(spacing: 16) {
                        Image(systemName: "circle.lefthalf.filled")
                            .font(.system(size: 22))
                            .frame(width: 28, alignment: .center)
                        Toggle(
                            "Dark Mode",
                            isOn: Binding(
                                get: { vm.isDarkMode },
                                set: { vm.isDarkMode = $0 }
                            )
                        )
                    }
                }

                Section(
                    header: Text("Tutorial").textCase(.none).font(.subheadline)
                ) {
                    NavigationLink(destination: Text("Tutorial View")) {
                        HStack(spacing: 16) {
                            Image(.mascotRunning)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Feeling lost?")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("I'll help you out!")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listRowBackground(Color.TGterniary)
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                vm.loadProfileImage(from: account?.profilePhoto)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSession())
}
