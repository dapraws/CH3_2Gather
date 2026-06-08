//
//  HomeView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 31/05/26.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @Binding var selectedTab: Int

    @EnvironmentObject private var session: AppSession
    @Query private var accounts: [Account]
    @Query private var userStates: [UserEventState]
    @Query private var events: [Event]

    @State private var homeTab: HomeTab = .completed
    @State private var selectedEvent: Event? = nil

    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }

    private var activeEventIds: Set<UUID> {
        Set(userStates.map { $0.eventId })
    }

    private var completedStates: [UserEventState] {
        userStates.filter { $0.isCompleted }
    }

    private var completedEventIds: Set<UUID> {
        Set(completedStates.map { $0.eventId })
    }

    private var activeEvent: Event? {
        events.first {
            activeEventIds.contains($0.id) && !completedEventIds.contains($0.id)
        }
    }

    private var upcomingEvents: [Event] {
        return
            events
            .filter {
                !activeEventIds.contains($0.id)
            }
    }

    private var sportsTried: Int {
        let categories =
            events
            .filter { activeEventIds.contains($0.id) }
            .flatMap { $0.category }
        return Set(categories).count
    }

    @State private var mapViewModel = MapViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    profileImageView

                    StatsRowView(
                        questsCompleted: completedStates.count,
                        sportsTried: sportsTried
                    )

                    if let event = activeEvent {
                        TodayEventCardView(
                            event: event,
                            onExplore: { selectedTab = 1 },
                            onGoToEvent: {
                                selectedTab = 1
                                selectedEvent = event
                            }
                        )
                    }

                    stickyTabView

                    if homeTab == .completed {
                        completedListView
                    } else {
                        upcomingListView
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .background(Color.backgroundPrimary)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(account?.username ?? "2Gather")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.TGprimary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.TGprimary)
                    }
                    .buttonStyle(.plain)
                }
            }
            .sheet(item: $selectedEvent) { event in
                EventDetailSheet(event: event)
            }
        }
    }

    private var profileImageView: some View {
        Group {
            if let path = account?.profilePhoto,
                let image = PhotoStorage.loadProfileImage(named: path)
            {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 92, height: 92)
                    .clipShape(Circle())
            } else {
                Image(.mascotProfile)
                    .resizable()
                    .frame(width: 92, height: 92)
                    .clipShape(Circle())
            }
        }
    }

    private var stickyTabView: some View {
        ZStack {
            HStack {
                Text("Completed")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.TGprimary.opacity(0.5))
                    .frame(maxWidth: .infinity)
                Text("Upcoming")
                    .font(.system(size: 15))
                    .foregroundStyle(Color.TGprimary.opacity(0.5))
                    .frame(maxWidth: .infinity)
            }
            .padding(.vertical, 10)
            .background(Color.backgroundSecondary)
            .clipShape(Capsule())

            HStack(spacing: 0) {
                tabLabel("Completed", isSelected: homeTab == .completed) {
                    homeTab = .completed
                }
                tabLabel("Upcoming", isSelected: homeTab == .upcoming) {
                    homeTab = .upcoming
                }
            }
            .padding(.horizontal, 5)
        }
    }

    private func tabLabel(
        _ title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.labelL)
                .foregroundStyle(isSelected ? Color.TGterniary : Color.clear)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 7)
                .background(isSelected ? Color.TGprimary : Color.clear)
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.2), value: homeTab)
    }

    private var completedListView: some View {
        VStack(spacing: 12) {
            if completedStates.isEmpty {
                emptyStateView(
                    message: "No completed events yet.\nGo finish one!"
                )
            } else {
                ForEach(completedStates) { state in
                    if let event = events.first(where: {
                        $0.id == state.eventId
                    }),
                        let proofPath = state.proofImagePath
                    {
                        CompletedEventCardView(
                            sportIcon: sportIcon(for: event),
                            proofPath: proofPath,
                            date: completedDate(event.date),
                            caption: state.caption
                        )
                        .frame(height: 160)
                    }
                }
            }
        }
    }

    private var upcomingListView: some View {
        VStack(spacing: 10) {
            if upcomingEvents.isEmpty {
                emptyStateView(
                    message: "No upcoming events.\nJoin one on the map!"
                )
            } else {
                ForEach(upcomingEvents) { event in
                    UpcomingEventCardView(
                        sportIcon: sportIcon(for: event),
                        eventName: event.name,
                        date: upcomingDate(event.date),
                        timeRange: event.formattedTime,
                        onTap: { selectedEvent = event }
                    )
                }
            }
        }
    }

    private func emptyStateView(message: String) -> some View {
        Text(message)
            .font(.system(size: 14))
            .foregroundStyle(Color.TGprimary.opacity(0.4))
            .multilineTextAlignment(.center)
            .padding(.vertical, 32)
            .frame(maxWidth: .infinity)
    }

    private func completedDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "d/M/yy"
        return f.string(from: date)
    }

    private func upcomingDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "d MMM"
        return f.string(from: date)
    }

    private func sportIcon(for event: Event) -> String {
        for category in event.category {
            if let sport = SportsCatalog.all.first(where: { $0.id == category })
            {
                return sport.icon
            }
        }
        return "figure.run"
    }
}

enum HomeTab {
    case completed, upcoming
}

#Preview {
    HomeView(selectedTab: .constant(0))
        .environmentObject(AppSession())
}
