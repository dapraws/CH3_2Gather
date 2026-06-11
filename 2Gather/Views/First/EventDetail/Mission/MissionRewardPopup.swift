//
//  MissionRewardPopup.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct MissionRewardPopup: View {
    
    var rewardMessage: String
    var onDismiss: () -> Void = {}
    
    var body: some View {
        VStack(spacing: 24) {
            
            Image(systemName: "star.fill")
                .font(.system(size: 60))
                .foregroundStyle(.yellow)
            
            Text("Mission Complete!")
                .font(.title)
                .bold()
                .foregroundStyle(Color(.black))
            
            Text(rewardMessage)
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
            
            Button("Awesome!", action: onDismiss)
                .buttonStyle(.borderedProminent)
        }
        .padding(32)
        .background(Color(.white))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(.black, lineWidth: 2)
        )
        .padding(16)
    }
}

#Preview {
    MissionRewardPopup(
        rewardMessage: "🏐 Nice shot! You captured the energy of the game!"
    )
    .withPreviewEnvironment()
}
