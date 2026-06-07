//
//  HomeView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 31/05/26.
//

import SwiftUI

// MARK: - Tab Enum
enum HomeTab {
    case completed, upcoming
}

// MARK: - HomeView
struct HomeView: View {
    @State private var selectedTab: HomeTab = .completed
    
    let completedItems: [(image: String, date: String, note: String?)] = [
        ("photo1", "2/6/26", "Very cute! AAAAAAA"),
        ("photo2", "2/6/26", nil),
        ("photo3", "1/6/26", "Great ride!")
    ]

    let upcomingItems: [(icon: String, name: String, date: String, time: String)] = [
        ("figure.run", "Run at Jerman Beach", "15 May", "17:00 - 19:00"),
        ("figure.run", "Run at Jerman Beach", "15 May", "17:00 - 19:00"),
        ("figure.run", "Run at Jerman Beach", "16 May", "17:00 - 19:00")
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {

                    // MARK: Avatar
                    profileHeader

                    // MARK: Stats Row
                    statsRow

                    // MARK: Today's Event
                    TodayEventCard(
                        eventName: "10 KM\nCycling Race",
                        onDetailTapped: { print("Detail tapped") }
                    )
                    .padding(.horizontal, 16)

                    // MARK: Tab Switcher
                    tabSwitcher

                    // MARK: Tab Content
                    if selectedTab == .completed {
                        completedSection
                    } else {
                        upcomingSection
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 100)
            }
            .background(Color.backgroundSecondary.ignoresSafeArea())
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Hans Hartowidjojo")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.textPrimary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        // Menu action
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.textPrimary)
                    }
                }
            }
        }
    }

    // MARK: - Profile Header
    private var profileHeader: some View {
        ZStack {
            Circle()
                .fill(Color.TGterniary)
                .frame(width: 88, height: 88)

            // Replace with your actual mascot/avatar image
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 88, height: 88)
                .foregroundColor(.TGprimary)
        }
    }

    // MARK: - Stats Row
    private var statsRow: some View {
        HStack(spacing: 0) {
            statItem(value: "15", label: "quests\ncompleted")

            Divider().frame(height: 36)

            statItem(icon: "figure.outdoor.cycle", label: "#1\nfavorite")

            Divider().frame(height: 36)

            statItem(value: "2", label: "sports\ntried")
        }
        .padding(.horizontal, 24)
    }

    private func statItem(value: String? = nil, icon: String? = nil, label: String) -> some View {
        VStack(spacing: 2) {
            if let value = value {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.TGsecondary)
            } else if let icon = icon {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.TGsecondary)
            }
            Text(label)
                .font(.system(size: 11))
                .foregroundColor(.textSecondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
    }

    // MARK: - Tab Switcher
    private var tabSwitcher: some View {
        HStack(spacing: 0) {
            tabButton(title: "Completed", tab: .completed)
            tabButton(title: "Upcoming", tab: .upcoming)
        }
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.backgroundElevated)
        )
        .padding(.horizontal, 16)
    }

    private func tabButton(title: String, tab: HomeTab) -> some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                selectedTab = tab
            }
        } label: {
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(selectedTab == tab ? .white : .textSecondary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 11)
                .background(
                    Group {
                        if selectedTab == tab {
                            Capsule()
                                .fill(Color.TGprimary)
                        }
                    }
                )
        }
    }

    // MARK: - Completed Section
    private var completedSection: some View {
        VStack(spacing: 12) {
            ForEach(completedItems.indices, id: \.self) { i in
                let item = completedItems[i]
                CompletedEventCard(
                    image: Image(item.image),
                    sportIcon: "figure.outdoor.cycle",
                    date: item.date,
                    note: item.note
                )
                .frame(height: 160)
                .padding(.horizontal, 16)
            }
        }
    }

    // MARK: - Upcoming Section
    private var upcomingSection: some View {
        VStack(spacing: 10) {
            ForEach(upcomingItems.indices, id: \.self) { i in
                let item = upcomingItems[i]
                UpcomingEventCard(
                    sportIcon: item.icon,
                    eventName: item.name,
                    date: item.date,
                    timeRange: item.time
                )
                .padding(.horizontal, 16)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}
