//
//  SportPreferencesCard.swift
//  2Gather
//
//  Created by RyanMFDR on 03/06/26.
//

import SwiftUI

struct SportTag: View {
    let sport: String
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Text(sport)
            .font(.headingS)
            .foregroundColor(Color.TGprimary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 19)
                    .fill(isSelected ? Color.TGterniary : Color.backgroundPrimary)
                    .stroke(.black, lineWidth: 1)
            )
            .onTapGesture {
                onTap()
            }
    }
}

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        let height = rows.map { row in
            row.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
        }.reduce(0) { $0 + $1 + spacing } - spacing
        return CGSize(width: proposal.width ?? 0, height: max(height, 0))
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let rows = computeRows(proposal: proposal, subviews: subviews)
        var y = bounds.minY
        for row in rows {
            var x = bounds.minX
            let rowHeight = row.map { $0.sizeThatFits(.unspecified).height }.max() ?? 0
            for subview in row {
                let size = subview.sizeThatFits(.unspecified)
                subview.place(at: CGPoint(x: x, y: y), proposal: .unspecified)
                x += size.width + spacing
            }
            y += rowHeight + spacing
        }
    }

    private func computeRows(proposal: ProposedViewSize, subviews: Subviews) -> [[LayoutSubviews.Element]] {
        var rows: [[LayoutSubviews.Element]] = [[]]
        var currentRowWidth: CGFloat = 0
        let maxWidth = proposal.width ?? .infinity

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if currentRowWidth + size.width > maxWidth, !rows[rows.endIndex - 1].isEmpty {
                rows.append([])
                currentRowWidth = 0
            }
            rows[rows.endIndex - 1].append(subview)
            currentRowWidth += size.width + spacing
        }
        return rows
    }
}

// MARK: Sport Preferences
struct SportPreferencesCard: View {
    let sports: [String]
    @State private var selectedSports: Set<String> = []

    var body: some View {
        FlowLayout(spacing: 10) {
            ForEach(sports, id: \.self) { sport in
                SportTag(
                    sport: sport,
                    isSelected: selectedSports.contains(sport)
                ) {
                    if selectedSports.contains(sport) {
                        selectedSports.remove(sport)
                    } else {
                        selectedSports.insert(sport)
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    SportPreferencesCard(
        sports: [
            "Running", "Swimming", "Volleyball", "Skateboarding",
            "Dancing", "Bouldering", "Muay Thai", "Ice Skating",
            "Surfing", "Tennis", "Weightlifting", "Cycling", "Basketball"
        ]
    )
}
