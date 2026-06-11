//
//  StatsRowView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 08/06/26.
//

import SwiftUI

struct StatsRowView: View {
    var questsCompleted: Int = 0
    var favoriteSportIcon: String = "figure.outdoor.cycle"
    var sportsTried: Int = 0

    var body: some View {
        HStack(spacing: 0) {
            statItem(value: "\(questsCompleted)", label: "quests\ncompleted")

            Rectangle()
                .fill(Color.TGOrange)
                .frame(width: 1, height: 35)

            statItem(icon: favoriteSportIcon, label: "#1\nfavorite")

            Rectangle()
                .fill(Color.TGOrange)
                .frame(width: 1, height: 35)

            statItem(value: "\(sportsTried)", label: "sports\ntried")
        }
        .padding(.horizontal, 0)
    }
}

private func statItem(
    value: String? = nil,
    icon: String? = nil,
    label: String
) -> some View {
    VStack(spacing: 10) {
        if let value = value {
            Text(value)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.TGOrange)
        } else if let icon = icon {
            Image(systemName: icon)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.TGOrange)
        }
        Text(label)
            .font(.system(size: 11))
            .foregroundColor(.TGBrownToWhite)
            .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
}

#Preview {
    StatsRowView(questsCompleted: 15, sportsTried: 3)
}
