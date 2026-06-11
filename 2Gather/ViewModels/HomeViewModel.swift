//
//  HomeViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 31/05/26.
//

import SwiftUI
import SwiftData

@Observable
class HomeViewModel {

    var homeTab: HomeTab = .completed
    var selectedEvent: Event? = nil

    func activeEvent(events: [Event], userStates: [UserEventState]) -> Event? {
        let activeIds = activeEventIds(userStates: userStates)
        let completedIds = completedEventIds(userStates: userStates)
        return events.first {
            activeIds.contains($0.id) && !completedIds.contains($0.id)
        }
    }

    func upcomingEvents(events: [Event], userStates: [UserEventState]) -> [Event] {
        let activeIds = activeEventIds(userStates: userStates)
        return events.filter { !activeIds.contains($0.id) }
    }

    func completedStates(userStates: [UserEventState]) -> [UserEventState] {
        userStates.filter { $0.isCompleted }
    }

    func sportsTried(events: [Event], userStates: [UserEventState]) -> Int {
        let activeIds = activeEventIds(userStates: userStates)
        let categories = events
            .filter { activeIds.contains($0.id) }
            .flatMap { $0.category }
        return Set(categories).count
    }

    func sportIcon(for event: Event) -> String {
        for category in event.category {
            if let sport = SportsCatalog.all.first(where: { $0.id == category }) {
                return sport.icon
            }
        }
        return "figure.run"
    }

    func completedDateString(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "d/M/yy"
        return f.string(from: date)
    }

    func upcomingDateString(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateFormat = "d MMM"
        return f.string(from: date)
    }


    func resetEventState(_ state: UserEventState, modelContext: ModelContext) {
        modelContext.delete(state)
    }


    private func activeEventIds(userStates: [UserEventState]) -> Set<UUID> {
        Set(userStates.map { $0.eventId })
    }

    private func completedEventIds(userStates: [UserEventState]) -> Set<UUID> {
        Set(userStates.filter { $0.isCompleted }.map { $0.eventId })
    }
}
