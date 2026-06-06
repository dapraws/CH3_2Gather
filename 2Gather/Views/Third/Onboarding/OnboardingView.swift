//
//  OnboardingView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI
import SwiftData

struct OnboardingView: View {

    @StateObject private var authViewModel = AuthViewModel(authService: AuthService())
    @StateObject private var viewModel = OnboardingViewModel()
    @EnvironmentObject private var session: AppSession

    var body: some View {
        ZStack(alignment: .top) {
            Group {
                switch viewModel.currentStep {
                case .welcoming:
                    WelcomingView(
                        onGetStarted: { viewModel.goToRegister() },
                        onSignIn: { viewModel.goToLogin() }
                    )
                case .login:
                    LoginView(
                        viewModel: authViewModel,
                        onTapRegister: {
                            authViewModel.clearMessages()
                            viewModel.goToRegister()
                        },
                        onSuccess: {
                            authViewModel.clearMessages()
                            viewModel.goToSportPreferences()
                        }
                    )
                case .register:
                    RegisterView(
                        viewModel: authViewModel,
                        onTapLogin: {
                            authViewModel.clearMessages()
                            viewModel.goToLogin()
                        },
                        onSuccess: {
                            authViewModel.clearMessages()
                            viewModel.goToSportPreferences()
                        }
                    )
                case .sportPreferences:
                    SportPreferencesView(
                        sports: viewModel.sports,
                        selectedSports: $viewModel.selectedSports,
                        onToggleSport: { viewModel.toggleSport($0) },
                        onContinue: { viewModel.goToPermission() },
                        onSkip: { viewModel.goToPermission() }
                    )
                case .permission:
                    PermissionView(
                        onContinue: { session.completeOnboarding() }
                    )
                }
            }
        }
        .overlay(alignment: .top) {
            if viewModel.currentStep != .welcoming {
            HStack(spacing: 80) {
                Button {
                    viewModel.goBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 26, weight: .semibold))
                        .foregroundStyle(Color.TGprimary)
                }

                HStack(spacing: 6) {
                    ForEach(1...4, id: \.self) { step in
                        Capsule()
                            .fill(step <= progressValue(for: viewModel.currentStep)
                                  ? Color.TGsecondary
                                  : Color.secondary.opacity(0.3))
                            .frame(height: 4)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
                
            }
        }
    }

    private func progressValue(for step: OnboardingViewModel.Step) -> Int {
        switch step {
        case .welcoming:         return 0
        case .login, .register:  return 1
        case .sportPreferences:  return 2
        case .permission:        return 3
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppSession())
        .modelContainer(for: Account.self, inMemory: true)
}
