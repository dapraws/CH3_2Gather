//
//  MissionBannerFullScreenView.swift
//  2Gather
//
//  Created by Eunice Santos on 07/06/26.
//

import SwiftUI

struct MissionBannerFullScreenView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var mission: Mission
    var event: Event
    
    var body: some View {
        ZStack{
            Color.TGFWhiteToDGreen
            VStack (spacing: 4){
                ZStack {
                    Image("map-pin-join")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90)
                    
                    Image(systemName: "target")
                        .foregroundStyle(.black)
                        .font(.system(size: 40, weight: .regular))
                        .offset(y: -8)
                }.shadow(radius: 1, x: 0, y: 1)
                    .padding(.bottom)
                
                Text(event.name).scaledFont(.headingL)
                    .padding(.bottom)
                    .foregroundColor(.TGBrownToYellow)
                EventInfoRowView(event: event)
                
                MissionCardView(mission: $mission, eventId: event.id, showButton: false)
                    .padding(.bottom)
                
                HStack {
                    Image("twoge-walking")
                        .resizable()
                        .scaledToFit()
                        .frame(width:120)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Let's Do It!")
                    }.buttonStyle(TGPrimaryButtonStyle())
                        .padding(.leading)
                }
            }.padding(.horizontal, 30)
            
        }.ignoresSafeArea()
        
        
    }
}

#Preview {
    MissionBannerFullScreenView(mission: .constant(TempData.soloMission1), event: TempData.event1 )
    .withPreviewEnvironment()
}
