//
//  OnboardingView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct OnboardingView: View {

    @State private var selection = 0

    var body: some View {
        VStack {
            //Progress bar
            if selection > 0 && selection < 4 {
                VStack {
                    HStack {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(selection >= 1 ? Color.TGsecondary : Color.backgroundSecondary)
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(selection >= 2 ? Color.TGsecondary : Color.backgroundSecondary)
                            .frame(height: 6)
                        RoundedRectangle(cornerRadius: 4)
                            .fill(selection >= 3 ? Color.TGsecondary : Color.backgroundSecondary)
                            .frame(height: 6)
                    }
                    // Back button
                    HStack {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .onTapGesture {
                                withAnimation { selection -= 1 }
                            }
                        Spacer()
                    }.padding(.bottom, 4)
                }.padding(.horizontal, 14)
            }

            // Main content
            Group {
                switch selection {
                case 0:
                    WelcomingView(
                        onGetStarted: {
                            withAnimation { selection = 1 }
                        },
                        onSignIn: {
                            withAnimation { selection = 4 }
                        }
                    ).transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                case 1:
                    RegisterView(
                        onContinue: {
                            withAnimation { selection = 2 }
                        },
                        onHaveAccount: {
                            withAnimation { selection = 4 }
                        }
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                case 2:
                    SportPreferencesView(
                        sports: [
                            "Running", "Walking", "Cycling", "Swimming",
                            "Judo", "Karate", "Taekwondo", "Yoga",
                            "Pilates", "Gym", "Weightlifting", "CrossFit",
                            "Climbing", "Surfing", "Skateboarding", "Rowing", "Archery",
                        ],
                        
                        onContinue: {
                            withAnimation { selection = 3 }
                        },
                        onSkip: {
                            withAnimation { selection = 3 }
                        }
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                case 3:
                    AccessPageView()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .trailing),
                                removal: .move(edge: .leading)
                            )
                        )
                case 4:
                    LoginView(
                        onLogin: {
                            // navigate to main app
                        },
                        onRegister: {
                            withAnimation { selection = 1 }
                        }
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                default:
                    WelcomingView(
                        onGetStarted: {
                            withAnimation { selection = 1 }
                        },
                        onSignIn: {
                            withAnimation { selection = 4 }
                        }
                    )
                    .transition(
                        .asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
