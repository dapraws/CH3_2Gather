//
//  SportPreferences.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct SportPreferencesView: View {
    let sports: [String]

    @State private var selectedSports: Set<String> = []
    @State private var showError: Bool = false

    var onContinue: () -> Void = {}
    var onSkip: () -> Void = {}

    var body: some View {
        VStack {
            VStack(spacing: 30) {
                Text("Tell us more about you!")
                    .font(.displayM)
                    .foregroundColor(.TGprimary)

                SportPreferencesCard(
                    sports: sports
                )
                Image(.mascotTG2)

                VStack {
                    Button(action: {
                        onContinue()
                    }) {
                        Text("Continue")
                            .font(.headingS)
                            .foregroundColor(.TGprimary)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .background(Color.TGterniary)
                            .cornerRadius(19)

                    }
                    Button(action: {
                        onSkip()
                    }) {
                        Text("Skip")
                            .font(.bodyL)
                            .foregroundColor(.TGsecondary)
                    }
                }.padding(.horizontal, 30)

            }.padding(.horizontal, 20)
            Spacer()
        }
    }
}

#Preview {
    SportPreferencesView(
        sports: [
            "Running",
            "Walking",
            "Cycling",
            "Swimming",
            "Judo",
            "Karate",
            "Taekwondo",
            "Yoga",
            "Pilates",
            "Gym",
            "Weightlifting",
            "CrossFit",
            "Climbing",
            "Surfing",
            "Skateboarding",
            "Rowing",
            "Archery",
        ]
    )
}
