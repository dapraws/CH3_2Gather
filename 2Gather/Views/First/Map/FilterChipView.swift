//
//  FilterChipView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 29/05/26.
//

import SwiftUI

struct FilterChipView: View {
    @Environment(\.colorScheme) var colorScheme

    var label: String
    var icon: String
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {

            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.TGFilterChipLabel)
                    .foregroundStyle(isSelected ? Color.TGBrown : Color.primary)
                Text(label)
                    .font(.TGFilterChipLabel)
                    .foregroundStyle(isSelected ? Color.TGBrown : Color.primary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(
                isSelected
                ? Color.TGYellow
                    : .white.opacity(0)
            )
            .glassEffect()
            .clipShape(Capsule())

        }
    }
}

#Preview {
    HStack {
        FilterChipView(
            label: "Running",
            icon: "figure.run",
            isSelected: false
        ) {}
        FilterChipView(
            label: "Running",
            icon: "figure.run",
            isSelected: true
        ) {}
    }.padding().background(.gray)

}
