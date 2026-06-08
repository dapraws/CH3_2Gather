//
//  TodayEventView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 07/06/26.
//

import SwiftUI

struct TodayEventCardView: View {
    var body: some View {
        ZStack {
            Image(.todayEventCard).resizable()
            HStack{
                Rectangle()
                    .fill(.white.opacity(0))
                VStack (alignment: .trailing){
                    Text("Today's Event")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.TGprimary.opacity(0.5))
                    Text("10 KM Cycling Race")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(.TGprimary)
                        .multilineTextAlignment(.trailing)
                    Button {
                        // go to event (event.id)
                        // switch to explore tab, focus on annotations, open detail sheet (event.id)
                    } label: {
                        Text("Let's do it!")
                            .font(.headingS)
                            .foregroundColor(.TGterniary)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.TGprimary)
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
    TodayEventCardView()
}
