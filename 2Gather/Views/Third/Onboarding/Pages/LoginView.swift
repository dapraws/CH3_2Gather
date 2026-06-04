//
//  LoginView.swift
//  2Gather
//
//  Created by RyanMFDR on 04/06/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false

    var onLogin: () -> Void = {}
    var onRegister: () -> Void = {}

    var body: some View {

        VStack(alignment: .leading, spacing: 34) {
            Image(.mascotAppLogo)

            Text("Login")
                .font(.displayM)
                .foregroundColor(.TGprimary)

            VStack(alignment: .leading, spacing: 10) {
                TGTextField(
                    placeholder: "Email",
                    text: $email,
                    icon: "envelope"
                )
                TGSecureField(
                    placeholder: "Password",
                    textPassword: $password,
                    isVisible: $isPasswordVisible
                )
            }

            VStack(spacing: 10) {
                // Login Button
                Button(action: {
                    onLogin()
                }) {
                    Text("Login")
                        .font(.headingS)
                        .foregroundColor(.TGprimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.TGterniary)
                        .cornerRadius(30)
                }
                .padding(.bottom, 16)

                HStack {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.TGprimary.opacity(0.5))
                    Text("or")
                        .font(.footnote)
                        .foregroundColor(Color.TGprimary.opacity(0.5))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(Color.TGprimary.opacity(0.5))
                }
                .padding(.bottom, 16)

                // Don't have an account
                Button(action: {
                    onRegister()
                }) {
                    Text("Don't have an account")
                        .font(.subheadline)
                        .foregroundColor(.TGprimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.backgroundPrimary)
                        .cornerRadius(30)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(
                                    Color.gray.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                }

            }.padding(.horizontal, 28)
        }
        .padding(.horizontal, 40)
        .padding(.top, 15)

    }
}

#Preview {
    LoginView()
}
