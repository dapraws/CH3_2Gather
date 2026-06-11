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
        return events.filter {
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
    @Namespace private var tabAnimation
    
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
            .background(Color.TGWhiteToDGreen)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(account?.username ?? "2Gather")
                        .scaledFont(.headingS)
                        .foregroundColor(.TGBrownToWhite)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "line.3.horizontal")
                            .foregroundColor(.TGBrownToWhite)
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
        HStack(spacing: 0) {
            tabLabel("Completed", tab: .completed)
            tabLabel("Upcoming", tab: .upcoming)
        }
        .padding(5)
        .background(Color.backgroundSecondary)
        .clipShape(Capsule())
    }
    
    private func tabLabel(_ title: String, tab: HomeTab) -> some View {
        let isSelected = homeTab == tab
        
        return Button {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.75)) {
                homeTab = tab
            }
        } label: {
            Text(title)
                .scaledFont(isSelected ? .labelL : .bodyM)
                .foregroundStyle(isSelected ? Color.TGYellowToBrown : Color.TGMauve)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 7)
                .background {
                    if isSelected {
                        Capsule()
                            .fill(Color.TGBrownToYellow.opacity(0.85))
                            .background(.ultraThinMaterial, in: Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(
                                        LinearGradient(
                                            colors: [.white.opacity(0.5), .clear, .white.opacity(0.1)],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .shadow(color: Color.black.opacity(0.15), radius: 4, x: 0, y: 2)
                            .matchedGeometryEffect(id: "activeTabBg", in: tabAnimation)
                    }
                }
        }
        .buttonStyle(.plain)
    }
    
    private var completedListView: some View {
        VStack(spacing: 12) {
            if completedStates.isEmpty {
                emptyEventStateView(
                    title: "Join your first event",
                    subtitle: "Make your life more interesting"
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
                emptyEventStateView(
                    title: "No upcoming events",
                    subtitle: "Join one on the map"
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
    
    private func emptyEventStateView(title: String, subtitle: String) -> some View {
        VStack(spacing: 16) {
            Image("mascot-split")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            
            VStack(spacing: 6) {
                Text(title)
                    .scaledFont(.headingM)
                    .foregroundColor(.TGBrownToWhite)
                
                Text(subtitle)
                    .scaledFont(.labelM)
                    .foregroundColor(.TGBrown.opacity(0.5))
            }
            .padding(.bottom, 8)
            
            Button {
                withAnimation {
                    selectedTab = 1
                }
            } label: {
                Text("Explore!")
                    .scaledFont(.labelL)
            }
            .buttonStyle(TGSecondaryButtonStyle())
            .frame(width: 160)
        }
        .padding(.vertical, 40)
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
        .withPreviewEnvironment()
        .modelContainer(for: Account.self, inMemory: true)
}
