//
//  Profile.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import PhotosUI
import SwiftData
import SwiftUI

struct ProfileSettingsView: View {
    @EnvironmentObject private var session: AppSession
    @Environment(\.modelContext) private var modelContext
    @Query private var accounts: [Account]
    var viewModel: SettingsViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            
            Color.TGFWhiteToDGreen
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 36) {
                        
                        VStack(spacing: 16) {
                            if let image = viewModel.profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 145, height: 145)
                                    .clipShape(Circle())
                            } else {
                                Image(.mascotProfile)
                                    .resizable()
                                    .frame(width: 145, height: 145)
                                    .clipShape(Circle())
                            }
                            
                            PhotosPicker(
                                selection: Binding(
                                    get: { viewModel.selectedPhotoItem },
                                    set: { viewModel.selectedPhotoItem = $0 }
                                ),
                                matching: .images
                            ) {
                                Text("Edit")
                                    .scaledFont(.labelL)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.TGOrange)
                            }
                        }
                        
                        VStack(spacing: 0) {
                            ProfileTextFieldRow(
                                title: "Username",
                                placeholder: "Your Username",
                                text: Binding(
                                    get: { account?.username ?? "" },
                                    set: { account?.username = $0 }
                                )
                            )
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            
                            Divider().padding(.leading, 16)
                            
                            ProfileTextFieldRow(
                                title: "Email",
                                placeholder: "Your Email",
                                text: Binding(
                                    get: { account?.email ?? "" },
                                    set: { account?.email = $0 }
                                )
                            )
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            
                            Divider().padding(.leading, 16)
                            
                            NavigationLink(
                                destination: PreferencesSettingsView(
                                    viewModel: viewModel
                                )
                            ) {
                                ProfileDataRow(
                                    title: "Sports preferences",
                                    value:
                                        "\(account?.preferenceSportIDs.count ?? 0)",
                                    showArrow: true
                                )
                            }
                            .buttonStyle(.plain)
                        }
                        .background(Color.TGWhiteToSGreen)
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                        
                    }
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            
            .onChange(of: viewModel.selectedPhotoItem) { _, newItem in
                viewModel.handlePhotoSelection(
                    item: newItem,
                    account: account,
                    modelContext: modelContext
                )
            }
            .onAppear {
                viewModel.loadProfileImage(from: account?.profilePhoto)
            }
        }
    }
    struct ProfileTextFieldRow: View {
        var title: String
        var placeholder: String
        @Binding var text: String
        
        var body: some View {
            HStack {
                Text(title).foregroundColor(.TGBrownToWhite).scaledFont(.bodyL)
                Spacer()
                TextField(placeholder, text: $text)
                    .scaledFont(.bodyL)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
        }
    }
    
    struct ProfileDataRow: View {
        var title: String
        var value: String
        var showArrow: Bool = false
        
        var body: some View {
            HStack {
                Text(title).foregroundColor(.TGBrownToWhite).scaledFont(.bodyL)
                Spacer()
                Text(value).foregroundColor(.gray.opacity(0.5)).scaledFont(.bodyM)   
                if showArrow {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color.gray.opacity(0.5))
                        .padding(.leading, 4)
                }
            }
            .padding(.vertical, 16)
            .padding(.horizontal, 16)
            .contentShape(Rectangle())
        }
    }
}

#Preview {
    NavigationStack {
        ProfileSettingsView(viewModel: SettingsViewModel())
            .environmentObject(AppSession())
    }
    .withPreviewEnvironment()
}
