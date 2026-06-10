//
//  SettingsView.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftData
import SwiftUI
import Lottie

struct SettingsView: View {
    @EnvironmentObject private var session: AppSession
    @Environment(\.modelContext) private var modelContext
    @Query private var accounts: [Account]
    @State private var viewModel = SettingsViewModel()
    
    @AppStorage("isDarkMode") private var isDarkMode = false
//    @State private var isMascotRunning = false

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
                                    .foregroundColor(.TGBrownToWhite)
                                Text(account?.email ?? "Together, We are fit!")
                                    .font(.subheadline)
                                    .foregroundColor(.TGMauveToGrey)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listRowBackground(Color.TGWhiteToSGreen)
                
                Section(
                    header: Text("Display & Appearance")
                        .textCase(.none)
                        .font(.subheadline)
                        .foregroundColor(.TGMauveToGrey)
                
                ) {
                    NavigationLink(destination: TextSizeSettingsView()) {
                        HStack(spacing: 16) {
                            Image(systemName: "textformat.size")
                                .font(.system(size: 22))
                                .frame(width: 28, alignment: .center)

                            Text("Text Size")
                        }
                        .foregroundColor(.TGBrownToWhite)
                    }
                    .listRowBackground(Color.TGWhiteToSGreen)

                    HStack(spacing: 16) {
                        Image(systemName: "circle.righthalf.filled")
                            .font(.system(size: 22))
                            .frame(width: 28, alignment: .center)
                        Toggle(
                                "Dark Mode",
                                isOn: Binding(
                                    get: { viewModel.isDarkMode },
                                    set: { viewModel.isDarkMode = $0 }
                                )
                            )
                        .tint(.TGOrange)
                    }
                    .foregroundColor(.TGBrownToWhite)
                }
                .listRowBackground(Color.TGWhiteToSGreen)

                Section(
                    header: Text("Tutorial").textCase(.none).font(.subheadline).foregroundColor(.TGMauveToGrey)
                ) {
                    NavigationLink(destination: Text("Tutorial View")) {
                        HStack(spacing: 20) {
                            
                            LottieView(animation: .named("animation-mascot-running"))
                                .playing()
                                .looping()
                                .scaleEffect(1.6)
                                .frame(width: 102, height: 81)
                                .padding(.leading, 8)
                                .id(isDarkMode)
                            
//                            Image(.mascotRunning)
                            
//                            LottieView(animation: .named("animation-mascot-running"))
//                                .playbackMode(isMascotRunning ? .playing(.fromProgress(0, toProgress: 1, loopMode: .loop)) : .paused)
//                                .scaleEffect(1.6)
//                                .frame(width: 102, height: 81)
//                                .padding(.leading, 10)
//                                .onLongPressGesture(minimumDuration: .infinity, perform: {
//                                }, onPressingChanged: { isPressing in
//                                    withAnimation {
//                                        isMascotRunning = isPressing
//                                    }
//                                })

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Feeling lost?")
                                    .font(.system(size: 14, weight: .semibold))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.TGBrown)
                                Text("I'll help you out!")
                                    .font(.system(size: 21, weight: .bold))
                                    .foregroundColor(.TGBrown)
                            }
                        }
                    }
                    .listRowBackground(
                        Image(.tutorialCard).resizable().scaledToFill()
                    )
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.TGFWhiteToDGreen)
            
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
