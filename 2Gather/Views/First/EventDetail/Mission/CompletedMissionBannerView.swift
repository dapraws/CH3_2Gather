//
//  CompletedMissionBannerView.swift
//  2Gather
//
//  Created by Eunice Santos on 07/06/26.
//

import SwiftUI
import Lottie

struct CompletedMissionBannerView: View {
    
    @Environment(\.dismiss) var dismiss
    var onDismiss: () -> Void
    var eventName: String
    var sport: SportCategory
    
    var body: some View {
        ZStack {
            Color.TGYellow
            //            Image(.mascotCheer)
            //                .resizable()
            //                .scaledToFill()
            //                .frame(width: 621, height: 621)
            LottieView(animation: .named("animation-mascot-cheer"))
                .playing()
                .looping()
                .configure { animationView in
                    animationView.animationSpeed = 1
                }
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .scaleEffect(1.6)
                .frame(maxHeight: 380)
            
            VStack {
                VStack (spacing: 10){
                    Image(systemName: sport.icon)
                        .font(.system(size: 30))
                    Text(eventName)
                        .scaledFont(.labelL)
                }
                .foregroundColor(.TGBrown)
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack (spacing: 30){
                        Button {
                            Void()
                        } label: {
                            Text("Share")
                        }.buttonStyle(TGShareBannerButtonStyle())
                            .frame(maxWidth: 120, minHeight: 36)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                            .scaledFont(.labelM)
                        }.foregroundStyle(Color.TGOrange)
                        
                    }
                    Spacer()
                }
                
                
            }.padding(.vertical, 125)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    CompletedMissionBannerView(onDismiss: {}, eventName: TempData.event1.name, sport: SportCategory.cycling)
    .withPreviewEnvironment()
}
