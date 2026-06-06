//
//  SportPreferencesView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import Flow
import SwiftUI

struct PreferencesView: View {
    let sports: [String]
    @Binding var selectedSports: Set<String>

    var onToggleSport: (String) -> Void = { _ in }
    var onContinue: () -> Void = {}
    var onSkip: () -> Void = {}

    var body: some View {
        ZStack {
            Rectangle().fill(.white)
            VStack(spacing: 30) {
                Text("Tell us more about you!")
                    .font(.displayM)
                    .foregroundColor(.TGprimary)
                Image(.mascotBasketball)

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
                            .foregroundColor(.TGprimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.TGterniary)
                            .cornerRadius(19)
                    }

                    Button {
                        onSkip()
                    } label: {
                        Text("Skip")
                            .font(.bodyL)
                            .foregroundColor(.TGsecondary)
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
    let onToggleSport: (String) -> Void

    var body: some View {
        HFlow {
            ForEach(sports, id: \.self) { sport in
                SportTag(
                    sport: sport,
                    isSelected: selectedSports.contains(sport)
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
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Text(sport)
                .font(.headingS)
                .foregroundColor(Color.TGprimary)
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
                .background(
                    RoundedRectangle(cornerRadius: 19)
                        .fill(
                            isSelected
                                ? Color.TGterniary : Color.backgroundPrimary
                        )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(
                            isSelected
                                ? Color.black : Color.TGprimary.opacity(0.3)
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
