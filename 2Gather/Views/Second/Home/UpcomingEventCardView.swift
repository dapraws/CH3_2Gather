//
//  UpcomingEventCardView.swift
//  2Gather
//
//  Created by RyanMFDR on 07/06/26.
//

import SwiftUI

struct UpcomingEventCardView: View {
    var sportIcon: String = "figure.run"
    var eventName: String = "Run at Jerman Beach"
    var date: String = "15 May"
    var timeRange: String = "17:00 - 19:00"
    var onTap: () -> Void = {}

    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.TGYellow)
                    .frame(width: 42, height: 42)
                Image(systemName: sportIcon)
                    .font(.system(size: 20))
                    .foregroundColor(Color.TGBrown)
            }

            VStack(alignment: .leading, spacing: 10) {
                Text(eventName)
                    .font(.headingS)
                    .foregroundColor(.TGBrownToWhite)

                HStack(spacing: 14) {
                    HStack(spacing: 4) {
                        Image(systemName: "calendar")
                            .font(.system(size: 20))
                            .foregroundColor(.TGRedToOrange)
                        Text(date)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.TGMauve)
                    }
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.system(size: 20))
                            .foregroundColor(.TGRedToOrange)
                        Text(timeRange)
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.TGMauve)
                    }
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.TGWhiteToDGreen)
                .stroke(Color(.separator), lineWidth: 1)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            onTap()
        }
    }
}

#Preview {
    VStack(spacing: 10) {
        UpcomingEventCardView(onTap: {})
        UpcomingEventCardView(
            sportIcon: "figure.outdoor.cycle",
            eventName: "Cycling at Sunset",
            date: "20 May",
            timeRange: "06:00 - 08:00",
            onTap: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
