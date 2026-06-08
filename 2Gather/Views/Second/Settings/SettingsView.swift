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
    @State private var viewModel = SettingsViewModel()

    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(
                        destination: ProfileSettingsView(viewModel: viewModel)
                    ) {
                        HStack(spacing: 16) {
                            if let image = viewModel.profileImage {
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
                            Image(systemName: "textformat.size")
                                .font(.system(size: 22))
                                .frame(width: 28, alignment: .center)

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
                                get: { viewModel.isDarkMode },
                                set: { viewModel.isDarkMode = $0 }
                            )
                        )
                    }
                }

                Section(
                    header: Text("Tutorial").textCase(.none).font(.subheadline)
                ) {
                    NavigationLink(destination: Text("Tutorial View")) {
                        HStack(spacing: 20) {
                            Image(.mascotRunning)
                                .resizable()
                                .frame(width: 102, height: 81)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Feeling lost?")
                                    .font(.system(size: 14, weight: .semibold))
                                    .fontWeight(.semibold)
                                Text("I'll help you out!")
                                    .font(.system(size: 21, weight: .bold))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                    .listRowBackground(
                        Image(.tutorialCard).resizable().scaledToFill()
                    )
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                viewModel.loadProfileImage(from: account?.profilePhoto)
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppSession())
}
