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
    var onDeleteTapped: (() -> Void)? = nil

    @State private var showDeleteConfirm = false

    private var proofImage: UIImage? {
        PhotoStorage.loadProofImage(named: proofPath)
    }

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Base — fixed size, ini yang define ukuran ZStack
            Color.clear
                .frame(maxWidth: .infinity)
                .frame(height: 160)

            // Background image — non-interactive
            if let image = proofImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .clipped()
                    .allowsHitTesting(false)
            } else {
                Rectangle()
                    .fill(Color.backgroundSecondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
                    .allowsHitTesting(false)
            }

            // Gradient — non-interactive
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
            .allowsHitTesting(false)

            // Info text — non-interactive
            VStack(alignment: .leading, spacing: 4) {
                Image(systemName: sportIcon)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                Text(date)
                    .font(.headingXXS)
                    .foregroundColor(.white)
                if let caption {
                    Text(caption)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(Capsule().fill(.thinMaterial))
                }
            }
            .padding()
            .allowsHitTesting(false)

            // Delete button — satu-satunya yang interactive
            if onDeleteTapped != nil {
                VStack {
                    HStack {
                        Spacer()
                        Button {
                            showDeleteConfirm = true
                        } label: {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                                .font(.system(size: 26))
                                .foregroundStyle(.white)
                                .shadow(radius: 2)
                        }
                        .padding(10)
                    }
                    Spacer()
                }
            }
        }
        .frame(height: 160)
        .cornerRadius(16)
        .clipped()
        .confirmationDialog(
            "Reset this event?",
            isPresented: $showDeleteConfirm,
            titleVisibility: .visible
        ) {
            Button("Reset", role: .destructive) { onDeleteTapped?() }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This event will return to Upcoming so you can join it again.")
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        CompletedEventCardView(
            sportIcon: "figure.run",
            proofPath: "some-proof.jpg",
            date: "8/6/26",
            caption: "Great ride!",
            onDeleteTapped: {}
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
