//
//  MissionCardView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftData
import SwiftUI

struct MissionCardView: View {
    @Binding var mission: Mission
    var eventId: UUID  // pass eventId instead of eventState
    var onComplete: (String) -> Void = { _ in }
    var showButton: Bool

    @Query private var allStates: [UserEventState]
    @State private var viewModel = MissionViewModel()

    // Now we can safely look up the right state reactively
    private var eventState: UserEventState? {
        allStates.first(where: { $0.eventId == eventId })
    }

    private var savedImage: UIImage? {
        guard let path = eventState?.proofImagePath else { return nil }
        return PhotoStorage.loadProofImage(named: path)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                let completed = eventState?.isCompleted == true
                Image(systemName: completed ? "checkmark.circle":"target")
                Text(completed ? "Quest Completed" : "Quest")
                    
            }.font(.system(size: 20, weight: .bold))
            .foregroundStyle(Color.TGprimary)
            
            Text(mission.desc)
                .foregroundStyle(Color.TGprimary)
                .font(.system(size: 17, weight: .regular))

            if eventState?.isCompleted == true {
                
                if let image = savedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 138)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .overlay(alignment: .bottomLeading) {
                            if let caption = eventState?.caption, !caption.isEmpty {
                                HStack {
                                    Text(caption)
                                        .font(.labelS)
                                        .foregroundStyle(Color.TGprimary)
                                        .lineLimit(1)
                                }
                                .padding(.horizontal, 14)
                                .frame(height: 27)
                                .background(
                                    RoundedRectangle(cornerRadius: 17.36)
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                        .brightness(0.7)
                                        .saturation(0)
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 17.36))
                                .padding([.leading, .top, .trailing])
                                .padding(.bottom, 6)
                            }
                        }
                        .onTapGesture {
                            if savedImage != nil { viewModel.showPreview = true }
                        }

                }

            } else {
                if showButton == true {
                    Button {
                        viewModel.showCamera = true
                    } label: {
                        HStack {
                            Image(systemName: "camera.fill")
                            Text("Snap a photo!")
                        }
    //                    .frame(maxWidth: .infinity)
    //                    .padding()
                    }
                    .buttonStyle(TGWhiteButtonStyle())
    //                .background(.white)
    //                .foregroundColor(Color.TGprimary)
    //                .clipShape(RoundedRectangle(cornerRadius: 12))
    //                .padding(.top, 8)
    //                .font(.headingS)
                }
                
                
            }
        }
        .padding(23)
        .frame(maxWidth: .infinity, alignment: .leading)
//        .background(Color.TGterniary)
//        .clipShape(RoundedRectangle(cornerRadius: 26))
        .background(
            RoundedRectangle(cornerRadius: 26)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.TGgradient, .TGterniary], startPoint: .top, endPoint: .bottom
                    )
                    .shadow(
                       .inner(
                           color: Color.black.opacity(0.25),
                           radius: 2,
                           x: 0,
                           y: 1
                       )
                   )
                )
        )
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CustomCameraView(
                onCapture: { image in viewModel.didCapture(image) },
                onCancel: { viewModel.showCamera = false }
            )
        }
        .fullScreenCover(isPresented: $viewModel.showPreview) {
            if eventState?.isCompleted == true, let image = savedImage {
                CompletedMissionPreview(
                    image: image,
                    caption: eventState?.caption,
                    onDismiss: { viewModel.showPreview = false }
                )
            } else if let image = viewModel.capturedImage {
                ProofPreviewView(
                    image: image,
                    onSend: { caption in
                        viewModel.submitProof(
                            image: image,
                            caption: caption,
                            mission: mission,
                            eventState: eventState,
                            onComplete: onComplete
                        )
                    },
                    onRetake: { viewModel.retake() }
                )
            }
        }
    }
}

#Preview("Incomplete") {
    MissionCardView(
        mission: .constant(TempData.soloMission1),
        eventId: UUID(),
        showButton: true
    )
    .padding()
}

#Preview("Complete") {
    MissionCardView(
        mission: .constant(TempData.completedMission),
        eventId: UUID(),
        showButton: true
    )
    .padding()
}
