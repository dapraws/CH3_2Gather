//
//  UpcomingCard.swift
//  2Gather
//
//  Created by RyanMFDR on 07/06/26.
//


import SwiftUI

struct UpcomingEventCard: View {
    var sportIcon: String = "figure.run"
    var eventName: String = "Run at Jerman Beach"
    var date: String = "15 May"
    var timeRange: String = "17:00 - 19:00"

    var body: some View {
        HStack(spacing: 14) {
            // Sport icon circle
            ZStack {
                Circle()
                    .fill(Color(hex: "#F5C518").opacity(0.25))
                    .frame(width: 46, height: 46)

                Image(systemName: sportIcon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(hex: "#F5C518"))
            }

            // Event info
            VStack(alignment: .leading, spacing: 6) {
                Text(eventName)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundColor(.primary)

                HStack(spacing: 14) {
                    // Date
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                        Text(date)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }

                    // Time
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 11))
                            .foregroundColor(.secondary)
                        Text(timeRange)
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
            }

            Spacer()
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.07), radius: 6, x: 0, y: 2)
        )
    }
}

#Preview {
    VStack(spacing: 10) {
        UpcomingEventCard()
        UpcomingEventCard(
            sportIcon: "figure.outdoor.cycle",
            eventName: "Cycling at Sunset",
            date: "20 May",
            timeRange: "06:00 - 08:00"
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
