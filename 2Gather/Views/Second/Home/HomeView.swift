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

    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var session: AppSession

    @Query private var accounts: [Account]
    @Query private var userStates: [UserEventState]
    @Query private var events: [Event]

    @State private var viewModel = HomeViewModel()
    @State private var stateToDelete: UserEventState? = nil
    @State private var showResetConfirm = false

    private var account: Account? {
        accounts.first { $0.id.uuidString == session.loggedInUserId }
    }

    private var completedStates: [UserEventState] {
        viewModel.completedStates(userStates: userStates)
    }
    
    private var upcomingEvents: [Event] {
        viewModel.upcomingEvents(events: events, userStates: userStates)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    profileImageView
                    
                    StatsRowView(
                        questsCompleted: completedStates.count,
                        sportsTried: viewModel.sportsTried(
                            events: events,
                            userStates: userStates
                        )
                    )

                    if let event = viewModel.activeEvent(
                        events: events,
                        userStates: userStates
                    ) {
                        TodayEventCardView(
                            event: event,
                            onExplore: { selectedTab = 1 },
                            onGoToEvent: {
                                selectedTab = 1
                                viewModel.selectedEvent = event
                            }
                        )
                    }

                    tabToggleView

                    if viewModel.homeTab == .completed {
                        if completedStates.isEmpty {
                            emptyStateView(
                                title: "Join your first event",
                                subtitle: "Make your life more interesting"
                            )
                        } else {
                            VStack(spacing: 12) {
                                ForEach(completedStates) { state in
                                    completedCard(for: state)
                                }
                            }
                        }
                    } else {
                        if upcomingEvents.isEmpty {
                            emptyStateView(
                                title: "No upcoming events",
                                subtitle: "Join one on the map"
                            )
                        } else {
                            VStack(spacing: 10) {
                                ForEach(upcomingEvents) { event in
                                    UpcomingEventCardView(
                                        sportIcon: viewModel.sportIcon(
                                            for: event
                                        ),
                                        eventName: event.name,
                                        date: viewModel.upcomingDateString(
                                            event.date
                                        ),
                                        timeRange: event.formattedTime,
                                        onTap: {
                                            viewModel.selectedEvent = event
                                        }
                                    )
                                }
                            }
                        }
                    }

                    Spacer(minLength: 20)
                }
                .padding(.horizontal)
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
            .sheet(item: $viewModel.selectedEvent) { event in
                EventDetailSheet(event: event)
            }
            .alert("Reset this event?", isPresented: $showResetConfirm) {
                    Button("Reset", role: .destructive) {
                    if let state = stateToDelete {
                        viewModel.resetEventState(
                            state,
                            modelContext: modelContext
                        )
                    }
                    stateToDelete = nil
                }
                Button("Cancel", role: .cancel) {
                    stateToDelete = nil
                }
            } message: {
                Text(
                    "This event will return to Upcoming so you can join it again."
                )
            }
        }
    }

    // MARK: - Profile Image

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

    // MARK: - Tab Toggle

    private var tabToggleView: some View {
        HStack(spacing: 4) {
            tabPill("My Events", tab: .completed)
            tabPill("Upcoming", tab: .upcoming)
        }
        .padding(4)
        .background(Color.backgroundSecondary, in: Capsule())
    }

    private func tabPill(_ label: String, tab: HomeTab) -> some View {
        let isSelected = viewModel.homeTab == tab
        return Text(label)
            .font(.labelL)
            .foregroundStyle(isSelected ? Color.TGYellowToBrown : Color.TGMauve)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
            .background(
                isSelected ? Color.TGBrownToYellow : Color.clear,
                in: Capsule()
            )
            .contentShape(Capsule())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.homeTab = tab
                }
            }
    }

    // MARK: - Completed Card

    @ViewBuilder
    private func completedCard(for state: UserEventState) -> some View {
        let eventId = state.eventId
        let matchedEvent: Event? = events.first { $0.id == eventId }
        if let event = matchedEvent, let proofPath = state.proofImagePath {
            CompletedEventCardView(
                sportIcon: viewModel.sportIcon(for: event),
                proofPath: proofPath,
                date: viewModel.completedDateString(event.date),
                caption: state.caption,
                onDeleteTapped: {
                    stateToDelete = state
                    showResetConfirm = true
                }
            )
            .frame(height: 160)
            .clipped()
        }
    }

    // MARK: - Empty State

    private func emptyStateView(title: String, subtitle: String) -> some View {
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
            Button {
                withAnimation { selectedTab = 1 }
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
}

enum HomeTab {
    case completed, upcoming
}

#Preview {
    NavigationStack {
        HomeView(selectedTab: .constant(0))
    }
    .environmentObject(AppSession())
}
