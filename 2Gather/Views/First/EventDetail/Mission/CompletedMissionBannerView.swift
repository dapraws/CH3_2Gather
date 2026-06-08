//
//  CompletedMissionBannerView.swift
//  2Gather
//
//  Created by Eunice Santos on 07/06/26.
//

import SwiftUI

struct CompletedMissionBannerView: View {
    
    @Environment(\.dismiss) var dismiss
    var onDismiss: () -> Void
    var eventName: String
    var sport: SportCategory
    
    var body: some View {
        ZStack {
            Color.TGterniary
            Image("completed-cheer")
                .resizable()
                .scaledToFill()
                .frame(width: 621, height: 621)
            
            VStack {
                VStack (spacing: 10){
                    Image(systemName: sport.icon)
                        .font(.system(size: 30))
                    Text(eventName)
                        .font(.TGFilterChipLabel)
                }//.padding(.top, 125)
                
                Spacer()
                
                HStack {
                    Spacer()
                    VStack (spacing: 3){
                        Button {
                            Void()
                        } label: {
                            Text("Share")
                                .font(.system(size: 14, weight: .medium))
                        }.buttonStyle(TGShareBannerButtonStyle())
                            .frame(maxWidth: 120, minHeight: 36)
                            .padding(.bottom)
                        
                        Button {
                            dismiss()
                        } label: {
                            Text("Close")
                        }.foregroundStyle(Color.TGred)
                            
                    }.padding(.bottom, 30)
                    .font(.system(size: 14, weight: .medium))
                    Spacer()
                }
                
                
            }.padding(.vertical, 125)
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    CompletedMissionBannerView(onDismiss: {}, eventName: TempData.event1.name, sport: SportCategory.cycling)
}
