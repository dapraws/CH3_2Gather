//
//  LoginView.swift
//  2Gather
//
//  Created by RyanMFDR on 04/06/26.
//

import SwiftData
import SwiftUI

struct LoginView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var session: AppSession
    
    @ObservedObject var viewModel: AuthViewModel
    @State private var isPasswordVisible = false
    
    let onTapRegister: () -> Void
    let onSuccess: () -> Void
    
    var body: some View {
        ZStack {
            Color.TGWhite
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Image(.mascotLogo)
                Text("Login")
                    .font(.displayM)
                    .foregroundColor(.TGBrown)
                CustomTextField(
                    placeholder: "Email",
                    text: $viewModel.loginEmail,
                    icon: "envelope"
                )
                
                CustomSecureField(
                    placeholder: "Password",
                    textPassword: $viewModel.loginPassword,
                    isVisible: $isPasswordVisible,
                )
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }
                
                VStack(alignment: .center, spacing: 16) {
                    Button {
                        let didLogin = viewModel.login(
                            modelContext: modelContext,
                            session: session
                        )
                        
                        if didLogin {
                            onSuccess()
                        }
                    } label: {
                        Text(viewModel.isLoading ? "Loading..." : "Login")
                            .font(.headingS)
                            .foregroundColor(.TGBrown)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.TGYellow)
                            .clipShape(Capsule())
                    }
                    .disabled(viewModel.isLoading)
                    
                    Button {
                        onTapRegister()
                    } label: {
                        Text("Don't have an account? Register here")
                            .font(.bodyL)
                            .foregroundColor(.TGBrown)
                            .frame(maxWidth: .infinity)
                            .clipShape(Capsule())
                        
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    LoginView(
        viewModel: AuthViewModel(authService: AuthService()),
        onTapRegister: {},
        onSuccess: {}
    )
    .environmentObject(AppSession())
    .modelContainer(for: Account.self, inMemory: true)
    .withPreviewEnvironment()
}
