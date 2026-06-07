//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct EventInfoRowView: View {

    var event: Event
    let spacingValue : CGFloat = 4
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                HStack(spacing: spacingValue) {
                    Image(systemName: "clock")
                        .foregroundStyle(Color.tempAccent)
                        .bold()
                    Text(event.formattedTime+"-12:00") //TO DO: remove hardcoded value 
                        .lineLimit(1)
                        .font(.bodyL)
                }
                
                HStack(spacing: spacingValue) {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color.tempAccent)
                        .bold()
                    Text(event.formattedDate)
                        .lineLimit(1)
                        .font(.bodyL)
                }
                
                HStack(spacing: spacingValue) {
                    Image(systemName: "mappin")
                        .foregroundStyle(Color.tempAccent)
                        .bold()
                    Text(event.venueName).font(.subheadline)
                        .lineLimit(1)
                        .font(.bodyL)
                }
            }
        }
    }
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
}
