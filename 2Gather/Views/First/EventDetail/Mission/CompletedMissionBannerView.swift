//
//  CompletedMissionBannerView.swift
//  2Gather
//
//  Created by Eunice Santos on 07/06/26.
//

import SwiftUI

struct CompletedMissionBannerView: View {

    var onDismiss: () -> Void
    var eventName: String
    var sport: SportCategory

    var body: some View {
        ZStack {
            Color.TGYellow
            Image(.mascotCheer)
                .resizable()
                .scaledToFill()
                .frame(width: 621, height: 621)

            VStack {
                VStack(spacing: 10) {
                    Image(systemName: sport.icon)
                        .font(.system(size: 30))
                    Text(eventName)
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.TGBrown)

                Spacer()

                HStack {
                    Spacer()
                    VStack(spacing: 30) {
                        Button {
                            // share placeholder
                        } label: {
                            Text("Share")
                                .font(.system(size: 14, weight: .medium))
                        }
                        .buttonStyle(TGShareBannerButtonStyle())
                        .frame(maxWidth: 120, minHeight: 36)

                        Button {
                            onDismiss()
                        } label: {
                            Text("Close")
                        }
                        .foregroundStyle(Color.TGOrange)
                    }
                    .font(.system(size: 14, weight: .medium))
                    Spacer()
                }
            }
            .padding(.vertical, 125)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    CompletedMissionBannerView(
        onDismiss: {},
        eventName: TempData.event1.name,
        sport: SportCategory.cycling
    )
}
