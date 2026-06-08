//
//  CompletedEventCardView.swift
//  2Gather
//
//  Created by RyanMFDR on 07/06/26.
//

import SwiftUI

struct CompletedEventCardView: View {
    var sportIcon: String
    var proofPath: String
    var date: String
    var caption: String?

    private var proofImage: UIImage? {
        PhotoStorage.loadProofImage(named: proofPath)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = proofImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .clipped()
            } else {
                Rectangle()
                    .fill(Color.backgroundSecondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
            }

            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.55), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )

            VStack(alignment: .leading, spacing: 4) {
                Image(systemName: sportIcon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Text(date)
                    .font(.headingXXS)
                    .foregroundColor(.white)
                Rectangle().fill(.white.opacity(0))
                if let caption = caption {
                    Text(caption)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(Capsule().fill(.thinMaterial))
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
            sportIcon: "figure.run",
            proofPath: "some-proof.jpg",
            date: "8/6/26",
            caption: "Great ride!"
        )
        CompletedEventCardView(
            sportIcon: "figure.run",
            proofPath: "some-proof.jpg",
            date: "7/6/26",
            caption: nil
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
