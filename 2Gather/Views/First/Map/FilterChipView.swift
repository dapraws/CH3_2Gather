//
//  FilterChipView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 29/05/26.
//

import SwiftUI

struct FilterChipView: View {
    var label: String
    var icon: String
    var color: Color
    var isSelected: Bool
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.TGfilterChipLabel)
                    .foregroundStyle(Color.TGprimary)
                Text(label)
                    .font(.TGfilterChipLabel)
                    .foregroundStyle(Color.TGprimary)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? .TGterniary : Color.backgroundPrimary)
            .shadow(radius: 1)
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    HStack {
        FilterChipView(
            label: "Running",
            icon: "figure.run",
            color: .red,
            isSelected: false
        ) {}
        FilterChipView(
            label: "Running",
            icon: "figure.run",
            color: .red,
            isSelected: true
        ) {}
    }.padding().background(.gray)

}
