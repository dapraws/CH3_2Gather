//
//  SportPreferences.swift
//  2Gather
//
//  Created by Andhika Satria on 03/06/26.
//

import SwiftUI

struct SportsPreferencesView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("selectedSports") private var selectedSportsString: String = "running"
    @State private var searchText: String = ""
    
    private var selectedSports: Set<SportCategory> {
        let categories = selectedSportsString.split(separator: ",").compactMap { SportCategory(rawValue: String($0)) }
        return Set(categories)
    }
    
    private var filteredSports: [SportCategory] {
        if searchText.isEmpty {
            return SportCategory.allCases
        } else {
            return SportCategory.allCases.filter {
                $0.label.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 1. Custom Navigation Bar
            HStack {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                }
                
                Spacer()
                
                Text("Sports Preferences")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            
            // MARK: - 2. Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search sports...", text: $searchText)
                    .autocorrectionDisabled(true)
                
                if !searchText.isEmpty {
                    Button(action: {
                        searchText = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 24)
            
            // MARK: - 3. Flow Layout Chips & Bottom Image
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    if filteredSports.isEmpty {
                        Text("No sports found.")
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    } else {
                        FlowLayout(spacing: 10) {
                            ForEach(filteredSports, id: \.self) { category in
                                SportChipView(
                                    label: category.label,
                                    icon: category.icon,
                                    isSelected: selectedSports.contains(category)
                                ) {
                                    toggleSelection(for: category)
                                }
                            }
                        }
                    }
                    
                    Spacer(minLength: 40)
                    
                    // MARK: - 4. Mascot Image
                    Image("SportPreferences")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                        .frame(height: 180)
                        .padding(.bottom, 32)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
            }
        }
        .background(Color(UIColor.systemGroupedBackground))
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden, for: .navigationBar)
    }
    
    // MARK: - Logika Toggle
    private func toggleSelection(for category: SportCategory) {
        var currentSelection = selectedSports
        
        if currentSelection.contains(category) {
            currentSelection.remove(category)
        } else {
            currentSelection.insert(category)
        }
        
        selectedSportsString = currentSelection.map { $0.rawValue }.joined(separator: ",")
        
        let impactMed = UIImpactFeedbackGenerator(style: .light)
        impactMed.impactOccurred()
    }
}

// MARK: - Custom Component: Sport Chip (Dengan Ikon)
struct SportChipView: View {
    var label: String
    var icon: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                
                Text(label)
                    .font(.system(size: 16, weight: .medium))
            }
            .foregroundColor(.black)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(isSelected ? Color(red: 247/255, green: 218/255, blue: 104/255) : Color.white)
            .overlay(
                Capsule()
                    .stroke(Color.black, lineWidth: 1)
            )
            .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}

// MARK: - Custom Component: Flow Layout
struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(in: proposal.width ?? 0, subviews: subviews, spacing: spacing)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(in: bounds.width, subviews: subviews, spacing: spacing)
        for (index, subview) in subviews.enumerated() {
            let point = result.frames[index].origin
            subview.place(at: CGPoint(x: point.x + bounds.minX, y: point.y + bounds.minY), proposal: .unspecified)
        }
    }

    struct FlowResult {
        var frames: [CGRect] = []
        var size: CGSize = .zero

        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            var width: CGFloat = 0

            for subview in subviews {
                let subviewSize = subview.sizeThatFits(.unspecified)
                
                if currentX + subviewSize.width > maxWidth, currentX > 0 {
                    currentY += lineHeight + spacing
                    currentX = 0
                    lineHeight = 0
                }

                frames.append(CGRect(x: currentX, y: currentY, width: subviewSize.width, height: subviewSize.height))
                currentX += subviewSize.width + spacing
                lineHeight = max(lineHeight, subviewSize.height)
                width = max(width, currentX)
            }
            size = CGSize(width: width, height: currentY + lineHeight)
        }
    }
}

#Preview {
    NavigationStack {
        SportsPreferencesView()
    }
}
