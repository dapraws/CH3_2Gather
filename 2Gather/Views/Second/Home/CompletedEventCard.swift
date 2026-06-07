//
//  CompletedCard.swift
//  2Gather
//
//  Created by RyanMFDR on 07/06/26.
//

import SwiftUI

struct CompletedEventCard: View {
    var image: Image = Image(systemName: "photo")
    var sportIcon: String = "figure.outdoor.cycle"
    var date: String = "2/6/26"
    var note: String? = nil

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Background image
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipped()

            // Gradient overlay for readability
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.55),
                    Color.clear
                ]),
                startPoint: .bottom,
                endPoint: .top
            )

            VStack(alignment: .leading, spacing: 4) {
                // Sport icon + date
                HStack(spacing: 6) {
                    Image(systemName: sportIcon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    Text(date)
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                }

                // Optional note pill
                if let note = note {
                    Text(note)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            Capsule()
                                .fill(Color.black.opacity(0.45))
                        )
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .cornerRadius(16)
        .clipped()
    }
}

#Preview {
    VStack(spacing: 12) {
        CompletedEventCard(
            image: Image(systemName: "photo"),
            sportIcon: "figure.outdoor.cycle",
            date: "2/6/26",
            note: "Very cute! AAAAAAA"
        )
        CompletedEventCard(
            image: Image(systemName: "photo"),
            sportIcon: "figure.outdoor.cycle",
            date: "2/6/26"
        )
    }
    .padding()
}
