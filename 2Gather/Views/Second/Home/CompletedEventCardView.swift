//
//  CompletedCard.swift
//  2Gather
//
//  Created by RyanMFDR on 07/06/26.
//

import SwiftUI

struct CompletedEventCardView: View {
    var sportIcon: String = "figure.outdoor.cycle"
    var date: String = "2/6/26"
    var caption: String? = nil

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(systemName: "photo")
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: 160)
                .clipped()

            LinearGradient(
                gradient: Gradient(colors: [
                    Color.black.opacity(0.55),
                    Color.clear,
                ]),
                startPoint: .bottom,
                endPoint: .top
            )

            VStack(alignment: .leading, spacing: 4) {
                VStack(spacing: 6) {
                    Image(systemName: sportIcon)
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    Text(date)
                        .font(.headingXXS)
                        .foregroundColor(.white)
                }
                Rectangle().fill(.white.opacity(0))
                if let caption = caption {
                    Text(caption)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(
                            Capsule()
                                .fill(.thinMaterial)
                        )
                }
            }
            .padding()
        }
        .frame(height: 160)
        .cornerRadius(16)
        .clipped()
    }
}

#Preview {
    VStack(spacing: 12) {
        CompletedEventCardView(
            sportIcon: "figure.outdoor.cycle",
            date: "2/6/26",
            caption: "Very cute! AAAAAAA"
        )
    }
    .padding()
}
