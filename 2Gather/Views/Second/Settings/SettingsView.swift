//
//  SettingsView.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    @AppStorage("username") private var username: String = "PhoenixWry"
    @AppStorage("email") private var email: String = "hanshw33@gmail.com"
    @AppStorage("profileImageData") private var profileImageData: Data = Data()
    
    @State private var profileImage: UIImage?
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 1. Custom Navigation Bar
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                }
                
                Spacer()
                
                Text("Settings")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            // MARK: - 2. Content List
            List {
                // MARK: Profile Section
                Section {
                    NavigationLink(destination: Profile()) {
                        HStack(spacing: 16) {
                            // Foto Profil Dinamis
                            if let image = profileImage {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            } else {
                                Image("ProfilImage") // Fallback asset
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(username)
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text(email)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                // MARK: Display & Appearance Section
                Section(header: Text("Display & Appearance").textCase(.none).font(.subheadline)) {
                    
                    NavigationLink(destination: TextSizeView()) {
                        HStack(spacing: 16) {
                            
                            HStack(alignment: .lastTextBaseline, spacing: 2) {
                                Text("A")
                                    .font(.system(size: 15, weight: .medium))
                                Text("A")
                                    .font(.system(size: 20, weight: .medium))
                            }
                            .frame(width: 28, alignment: .center)
                            .foregroundColor(.primary)
                            
                            Text("Text Size")
                        }
                    }
                    
                    HStack(spacing: 16) {
                        Image(systemName: "circle.lefthalf.filled")
                            .font(.system(size: 22))
                            .frame(width: 28, alignment: .center)
                            .foregroundColor(.primary)
                        
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                }
                
                // MARK: Tutorial Section
                Section(header: Text("Tutorial").textCase(.none).font(.subheadline)) {
                    
                    NavigationLink(destination: Text("Tutorial View")) {
                        HStack(spacing: 16) {
                            Image("icon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                            
                            VStack(alignment: .leading, spacing: 2) {
                                Text("Feeling lost?")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                
                                Text("I'll help you out!")
                                    .font(.headline)
                                    .fontWeight(.bold)
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                    .listRowBackground(Color.TGterniary)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
        .onAppear {
            // Memuat gambar saat halaman dibuka
            if !profileImageData.isEmpty, let savedImage = UIImage(data: profileImageData) {
                profileImage = savedImage
            }
        }
    }
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}
