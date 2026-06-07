//
//  MissionSectionView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct MissionSectionView: View {

    @Binding var mission: Mission
    var eventId: UUID
    var isJoined: Bool
    var onJoin: () -> Void
    var onMissionComplete: (String) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .center, spacing: 12) {

            if isJoined {
                // UNLOCKED
                MissionCardView(
                    mission: $mission,
                    eventId: eventId,
                    onComplete: { rewardMessage in
                        onMissionComplete(rewardMessage)
                    }, showButton: true
                    
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))

            } else {
                // LOCKED
                ZStack {

                    VStack(alignment: .center) {
                        Image(systemName: "lock.fill")
                            .font(.system(size: 64, weight: .bold))
                        
                        VStack {
                            Text("JOIN THE EVENT")
                            Text("TO GET A QUEST")
                        }.font(.headingS)
                    }
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.TGprimary)
                    .padding(.vertical, 50)
                    .background(
                        RoundedRectangle(cornerRadius: 26)
                            .foregroundStyle(
                                LinearGradient(
                                    colors: [.TGgradient, .TGterniary, .TGterniary], startPoint: .top, endPoint: .bottom
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
                }
                .transition(.opacity)
            }
            
            if !isJoined {
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8))
                    {
                        onJoin()
                    }
                } label: {
                    Text("Join")
//                        .fontWeight(.semibold)
//                        .frame(maxWidth: .infinity)
//                        .padding()
                }.buttonStyle(TGPrimaryButtonStyle())

//                .buttonStyle(.plain)
//                .background(Color.TGprimary)
//                .foregroundColor(.white)
//                .clipShape(RoundedRectangle(cornerRadius: 12))
//                //.frame(width: 344, height: 50)
//                .frame(maxWidth: .infinity, maxHeight: 50)
//                .transition(
//                    .asymmetric(
//                        insertion: .opacity,
//                        removal: .scale(scale: 0.8).combined(with: .opacity)
//                    )
//                )
            }

        }
        .animation(.default, value: isJoined)
    }
}

#Preview("Locked") {
    MissionSectionView(
        mission: .constant(TempData.event1.mission),
        eventId: TempData.event1.id,
        isJoined: false,
        onJoin: {}
    )
    .padding()
}

#Preview("Unlocked") {
    MissionSectionView(
        mission: .constant(TempData.event1.mission),
        eventId: TempData.event1.id,
        isJoined: true,
        onJoin: {}
    )
    .padding()
}
