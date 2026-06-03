//
//  SettingsView.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftUI

struct SettingsView: View {
    // Membaca pengaturan tema
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                // MARK: - 1. Profile Section
                Section {
                    NavigationLink(destination: Profile()) {
                        HStack(spacing: 16) {
                            Image("ProfilImage")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray)
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("PhoenixWry")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                                
                                Text("hanshw33@gmail.com")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding(.vertical, 8)
                    }
                }
                
                // MARK: - 2. Display & Appearance Section
                Section(header: Text("Display & Appearance").textCase(.none).font(.subheadline)) {
                    
                    NavigationLink(destination: TextSizeView()) {
                        HStack(spacing: 16) {
                            Text("A")
                                .font(.system(size: 14))
                            Text("A")
                                .font(.system(size: 18))
                            
                            Text("Text Size")
                                .padding(.leading, 6)
                        }
                    }
                    
                    HStack(spacing: 12) {
                        Image(systemName: "circle.lefthalf.filled")
                            .font(.system(size: 20))
                            .frame(width: 24)
                        
                        Toggle("Dark Mode", isOn: $isDarkMode)
                    }
                }
                
                // MARK: - 3. Tutorial Section
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
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
