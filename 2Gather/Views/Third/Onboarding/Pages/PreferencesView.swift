//
//  PreferencesView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import Flow
import SwiftUI
import Lottie

struct PreferencesView: View {
    let sports: [String]
    @Binding var selectedSports: Set<String>

    var onToggleSport: (String) -> Void = { _ in }
    var onContinue: () -> Void = {}
    var onSkip: () -> Void = {}

    var body: some View {
        ZStack {
            Color.TGWhite
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("Tell us more about you!")
                    .font(.displayM)
                    .foregroundColor(.TGBrown)
                
//                Image(.mascotBasketball)
                
                LottieView(animation: .named("animation-mascot-basketball"))
                    .playing()
                    .looping()
                    .frame(width: 250, height: 250)

                SportPreferencesLayout(
                    sports: sports,
                    selectedSports: $selectedSports,
                    onToggleSport: onToggleSport
                )
                Spacer()
                VStack(spacing: 12) {
                    Button {
                        onContinue()
                    } label: {
                        Text("Continue")
                            .font(.headingS)
                            .foregroundColor(.TGBrown)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.TGYellow)
                            .cornerRadius(19)
                    }

                    Button {
                        onSkip()
                    } label: {
                        Text("Skip")
                            .font(.bodyL)
                            .foregroundColor(.TGOrange)
                    }
                }
            }
            .padding()
            .padding(.top, 40)
        }
    }
}

struct SportPreferencesLayout: View {
    let sports: [String]
    @Binding var selectedSports: Set<String>
    var isDynamicTheme: Bool = false
    let onToggleSport: (String) -> Void

    var body: some View {
        HFlow {
            ForEach(sports, id: \.self) { sport in
                SportTag(
                    sport: sport,
                    isSelected: selectedSports.contains(sport),
                    isDynamicTheme: isDynamicTheme
                ) {
                    onToggleSport(sport)
                }
            }
        }
    }
}

struct SportTag: View {
    let sport: String
    let isSelected: Bool
    var isDynamicTheme: Bool = false
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(sport)
                .font(.headingS)
                .foregroundColor(
                    isSelected ? .TGBrown : (isDynamicTheme ? .TGBrownToWhite : .TGBrown)
                                )
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                                            .fill(
                                                isSelected ? Color.TGYellow : (isDynamicTheme ? Color.TGWhiteToSGreen : Color.TGWhite)
                                            )
                                    )
                .overlay(
                    Capsule()
                        .stroke(
                            isSelected ? Color.TGBrown : (isDynamicTheme ? Color.TGBrownToWhite.opacity(0.3) : Color.TGBrown.opacity(0.3)),
                            lineWidth: 1
                        )
                )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PreferencesView(
        sports: SportsCatalog.all.map { $0.name },
        selectedSports: .constant([]),
        onToggleSport: { _ in },
        onContinue: {},
        onSkip: {}
    )
}
