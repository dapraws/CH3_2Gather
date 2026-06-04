//
//  RegisterView.swift
//  2Gather
//
//  Created by RyanMFDR on 03/06/26.
//

import SwiftUI

struct RegisterView: View {
    @State private var fullName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isConfirmPasswordVisible: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    
    //Navigate
    var onContinue: () -> Void = {}
    var onHaveAccount: () -> Void = {}
    
    // MARK: Validation
    private var isEmailValid: Bool {
        let regex = /^[A-Za-z0-9._%+\-]+@[A-Za-z0-9.\-]+\.[A-Za-z]{2,}$/
        return email.wholeMatch(of: regex) != nil
    }
    
    private func validate() -> String? {
            if fullName.trimmingCharacters(in: .whitespaces).isEmpty {
                return "Please enter your full name."
            }
            if email.trimmingCharacters(in: .whitespaces).isEmpty {
                return "Please enter your email."
            }
            if !isEmailValid {
                return "Please enter a valid email address."
            }
            if password.isEmpty {
                return "Please enter a password."
            }
            if confirmPassword.isEmpty {
                return "Please confirm your password."
            }
            if password != confirmPassword {
                return "Passwords do not match."
            }
            return nil // all good
        }

    var body: some View {

        VStack(alignment: .leading, spacing: 34) {
            Image(.mascotAppLogo)

            Text("Register")
                .font(.displayM)
                .foregroundColor(.TGprimary)

            VStack(alignment: .leading, spacing: 10) {
                TGTextField(
                    placeholder: "Email",
                    text: $email,
                    icon: "envelope"
                )
                TGTextField(
                    placeholder: "Full name",
                    text: $fullName,
                    icon: "person"
                )
                TGSecureField(
                    placeholder: "Password",
                    textPassword:  $password,
                    isVisible: $isPasswordVisible
                )
                TGSecureField(
                    placeholder: "Confirm password",
                    textPassword: $confirmPassword,
                    isVisible: $isConfirmPasswordVisible
                )
            }
            VStack(spacing: 10) {
                //Continue Button
                Button(action: {
                    if let error = validate() {
                        alertMessage = error
                        showAlert = true
                    } else {
                        onContinue()
                    }
                }) {
                    Text("Continue")
                        .font(.headingS)
                        .foregroundColor(.TGprimary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.TGterniary)
                        .cornerRadius(30)
                }
                .padding(.bottom, 16)
                .alert("Hold on!", isPresented: $showAlert) {
                    Button("OK", role: .cancel) {
                        
                    }
                        } message: {
                            Text(alertMessage)
                        }

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

                // Have an account
                Button(action: {
                    onHaveAccount()
                }) {
                    Text("Have an account")
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
        .ignoresSafeArea(.keyboard)
        .padding(.horizontal, 40)
        .padding(.top, 15)

    }
}
#Preview {
    RegisterView()
}
