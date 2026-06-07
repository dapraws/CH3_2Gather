//
//  TodayEvent.swift
//  2Gather
//

import SwiftUI

struct TodayEventCard: View {
    var eventName: String = "10 KM\nCycling Race"
    var onDetailTapped: () -> Void = {}

    var body: some View {
        ZStack {
            // Yellow background
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.TGterniary)

            // Decorative soft circle
            Circle()
                .fill(Color.white.opacity(0.25))
                .frame(width: 140, height: 140)
                .offset(x: 40, y: -30)

            HStack(alignment: .bottom, spacing: 0) {
                // Mascot image — replace "mascot" with your actual asset name
                Image(.mascotTodayEvent)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .offset(y: 10)

                Spacer()

                VStack(alignment: .trailing, spacing: 12) {
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("Today's event")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.TGprimary.opacity(0.6))

                        Text(eventName)
                            .font(.system(size: 22, weight: .bold))
                            .multilineTextAlignment(.trailing)
                            .foregroundColor(.TGprimary)
                    }

                    Button(action: onDetailTapped) {
                        HStack(spacing: 4) {
                            Text("Detail")
                                .font(.system(size: 14, weight: .semibold))
                            Text(">>")
                                .font(.system(size: 12, weight: .bold))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(Color.TGprimary)
                        )
                    }
                }
                .padding(.trailing, 16)
                .padding(.bottom, 16)
            }
            .padding(.leading, 8)
        }
        .frame(height: 160)
        .clipped()
    }
}

#Preview {
    TodayEventCard()
        .padding()
}
