//
//  TodayEventView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 07/06/26.
//

import SwiftUI

struct TodayEventCardView: View {
    var event: Event?
    var onExplore: () -> Void = {}
    var onGoToEvent: () -> Void = {}
    
    var body: some View {
        if let event = event {
            activeEventCard(event: event)
        } else {
            //            exploreCard
        }
    }
    
    private func activeEventCard(event: Event) -> some View {
        ZStack {
            Image(.todayEventCard).resizable()
            HStack {
                Rectangle().fill(.white.opacity(0))
                VStack(alignment: .trailing) {
                    Text("Today's Event")
                        .scaledFont(.labelM)
                        .foregroundColor(.TGBrown.opacity(0.5))
                    Text(event.name)
                        .scaledFont(.displayM)
                        .foregroundColor(.TGBrown)
                        .multilineTextAlignment(.trailing)
                    Button(action: onGoToEvent) {
                        Text("Let's do it!")
                            .scaledFont(.headingS) 
                            .foregroundColor(.TGYellow)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.TGBrown)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
        .frame(height: 212)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    private var exploreCard: some View {
        ZStack {
            Image(.todayEventCard).resizable()
            HStack {
                Rectangle().fill(.white.opacity(0))
                VStack(alignment: .trailing) {
                    Text("No event today")
                        .scaledFont(.labelM)
                        .foregroundColor(.TGBrown.opacity(0.5))
                    Text("Lets explore some event")
                        .scaledFont(.headingL)
                        .foregroundColor(.TGBrown)
                        .multilineTextAlignment(.trailing)
                    Button(action: onExplore) {
                        Text("Explore now!")
                            .scaledFont(.headingS)
                            .foregroundColor(.TGYellow)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.TGBrown)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 16)
        }
        .frame(height: 212)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    VStack(spacing: 16) {
        TodayEventCardView(event: TempData.event1, onExplore: {}, onGoToEvent: {})
        TodayEventCardView(event: nil, onExplore: {}, onGoToEvent: {})
    }
    .padding()
    .withPreviewEnvironment()
}
