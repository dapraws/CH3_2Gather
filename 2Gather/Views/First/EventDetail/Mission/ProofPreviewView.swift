//
//  ProofPreviewView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 30/05/26.
//

import SwiftUI

struct ProofPreviewView: View {
    var image: UIImage
    var onSend: (String) -> Void
    var onRetake: () -> Void

    @State private var caption: String = ""
    @FocusState private var captionFocused: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            Image(uiImage: image)
                .resizable()
                .background()
                .scaledToFit()
                .ignoresSafeArea()

            VStack {
                HStack {
                    Button(action: onRetake) {
                        Image(systemName: "arrow.uturn.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.TGWhiteToBrown .opacity(0.3), in: Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Spacer()

                HStack(spacing: 12) {
                    TextField("Add a caption...", text: $caption)
                        .focused($captionFocused)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Color.TGWhiteToBrown , in: Capsule())
                        .foregroundColor(.white)

                    Button(action: { onSend(caption) }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.TGBrown)
                            .frame(width: 44, height: 44)
                            .background(Color.TGYellow, in: Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .onTapGesture {
            captionFocused = false
        }
    }
}

#Preview {
    ProofPreviewView(
        image: UIImage(systemName: "photo")!,
        onSend: { caption in print("Sent: \(caption)") },
        onRetake: { print("Retake") }
    )
}
