//
//  StatsRowView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 08/06/26.
//

import SwiftUI

struct StatsRowView: View {
    var body: some View {
        HStack(spacing: 0) {
            statItem(value: "15", label: "quests\ncompleted")

            Rectangle()
                .fill(Color.TGprimary)
                .frame(width: 1, height: 35)

            statItem(icon: "figure.outdoor.cycle", label: "#1\nfavorite")

            Rectangle()
                .fill(Color.TGprimary)
                .frame(width: 1, height: 35)


            statItem(value: "2", label: "sports\ntried")
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
                .foregroundColor(.TGsecondary)
        } else if let icon = icon {
            Image(systemName: icon)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(.TGsecondary)
        }
        Text(label)
            .font(.system(size: 11))
            .foregroundColor(.TGprimary)
            .multilineTextAlignment(.center)
    }
    .frame(maxWidth: .infinity)
}

#Preview {
    StatsRowView()
}
