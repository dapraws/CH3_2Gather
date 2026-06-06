//
//  RegisterView.swift
//  2Gather
//
//  Created by RyanMFDR on 03/06/26.
//

import SwiftData
import SwiftUI

struct RegisterView: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var session: AppSession

    @ObservedObject var viewModel: AuthViewModel
    @State private var isPasswordVisible = false

    let onTapLogin: () -> Void
    let onSuccess: () -> Void

    var body: some View {
        ZStack {
            Rectangle().fill(.white)
            VStack(alignment: .leading, spacing: 16) {
                Image(.mascotLogo)
                Text("Register")
                    .font(.displayM)
                    .foregroundColor(.TGprimary)
                CustomTextField(
                    placeholder: "Username",
                    text: $viewModel.registerUsername,
                    icon: "person.crop.circle"
                )

                CustomTextField(
                    placeholder: "Email",
                    text: $viewModel.registerEmail,
                    icon: "envelope"
                )

                CustomSecureField(
                    placeholder: "Password",
                    textPassword: $viewModel.registerPassword,
                    isVisible: $isPasswordVisible
                )

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .font(.footnote)
                }

                VStack(alignment: .center, spacing: 16) {
                    Button {
                        let didRegister = viewModel.register(
                            modelContext: modelContext,
                            session: session
                        )

                        if didRegister {
                            onSuccess()
                        }
                    } label: {
                        Text(viewModel.isLoading ? "Loading..." : "Register")
                            .font(.headingS)
                            .foregroundColor(.TGprimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.TGterniary)
                            .clipShape(Capsule())
                    }
                    .disabled(viewModel.isLoading)

                    Button {
                        onTapLogin()
                    } label: {
                        Text("I already have an account")
                            .font(.bodyL)
                            .foregroundColor(.TGsecondary)
                            .frame(maxWidth: .infinity)
                            .font(.footnote)
                            .foregroundStyle(.blue)
                            .clipShape(Capsule())
                    }
                }
            }.padding()
        }
    }
}

#Preview {
    RegisterView(
        viewModel: AuthViewModel(authService: AuthService()),
        onTapLogin: {},
        onSuccess: {}
    )
    .environmentObject(AppSession())
    .modelContainer(for: Account.self, inMemory: true)
}
