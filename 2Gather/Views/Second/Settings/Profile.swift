//
//  Profile.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftUI

struct Profile: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("username") private var username: String = "PhoenixWry"
    @AppStorage("email") private var email: String = "hanshw33@gmail.com"
    
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
                
                Text("Profile")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
            
            ScrollView {
                VStack(spacing: 36) {
                    // MARK: - 2. Profile Image & Edit Button
                    VStack(spacing: 16) {
                        Image("ProfilImage")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .foregroundColor(.gray)
                        
                        Button(action: {
                            // Edit Photo
                        }) {
                            Text("Edit")
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.TGsecondary)
                        }
                    }
                    
                    // MARK: - 3. Data Section (Custom Grouped List)
                    VStack(spacing: 0) {
                        ProfileTextFieldRow(title: "Username", placeholder: "Your Username", text: $username)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                        
                        Divider()
                            .padding(.leading, 16)
                        
                        ProfileTextFieldRow(title: "Email", placeholder: "Your Email", text: $email)
                            .keyboardType(.emailAddress) //
                            .textInputAutocapitalization(.never)
                        
                        Divider()
                            .padding(.leading, 16)
                        
                        NavigationLink(destination: Text("Sports Preferences View")) {
                            ProfileDataRow(title: "Sports preferences", value: "4", showArrow: true)
                        }
                        .buttonStyle(.plain)
                    }
                    .background(Color(UIColor.secondarySystemGroupedBackground))
                    .cornerRadius(16)
                    .padding(.horizontal, 20)
                }
                .padding(.top, 10)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
}

// MARK: - Reusable Component untuk TextField
struct ProfileTextFieldRow: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            TextField(placeholder, text: $text)
                .multilineTextAlignment(.trailing)
                .foregroundColor(.gray)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
    }
}

// MARK: - Reusable Component untuk Baris Data Biasa
struct ProfileDataRow: View {
    var title: String
    var value: String
    var showArrow: Bool = false
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .foregroundColor(.gray)
            
            if showArrow {
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .padding(.leading, 4)
            }
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    NavigationStack {
        Profile()
    }
}
