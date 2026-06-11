//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI
import GeoToolbox

struct EventInfoRowView: View {
    
    var event: Event
    let spacingValue : CGFloat = 4
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                HStack(spacing: spacingValue) {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.TGRedToOrange)
                        .bold()
                    Text(event.formattedTime)
                        .lineLimit(1)
                        .scaledFont(.bodyL)
                        .foregroundColor(.TGBrownToWhite)
                }
                
                HStack(spacing: spacingValue) {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.TGRedToOrange)
                        .bold()
                    Text(event.formattedDate)
                        .lineLimit(1)
                        .scaledFont(.bodyL)
                        .foregroundColor(.TGBrownToWhite)
                }
                
                HStack(spacing: spacingValue) {
                    Image(systemName: "mappin")
                        .foregroundStyle(Color.TGRedToOrange)
                        .bold()
                    Text(event.venueName)
                        .lineLimit(1)
                        .scaledFont(.bodyL) 
                        .foregroundColor(.TGBrownToWhite)
                }
            }
        }
    }
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
    .withPreviewEnvironment()
}
