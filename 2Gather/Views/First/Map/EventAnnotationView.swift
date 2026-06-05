//
//  EventAnnotationView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventAnnotationView: View {
    var event: Event
    var viewModel: MapViewModel
    var isJoined: Bool = false
    var isCompleted: Bool = false
    var isSelecteds: Bool = false

    private var sport: SportCategory {
        SportCategory.from(categories: event.category)
    }

    private var isSelected: Bool {
        viewModel.highlightedEventId == event.id
    }

    private var pinImage: String {
        if isCompleted {
            return "map-pin-completed"
        } else if isJoined {
            return "map-pin-joined"
        } else {
            return "map-pin-default"
        }
    }
    
    private var iconImage: String {
        if isCompleted {
            return "checkmark"
        } else if isJoined {
            return "target"
        } else {
            return sport.icon
        }
    }
    
    private var iconSize: CGFloat {
        if isCompleted {
            return 18
        } else if isJoined {
            return 20
        } else {
            return 16
        }
    }

    private var iconColor: Color {
        isJoined ? .black : .white
    }

    var body: some View {
        ZStack {
            Image(pinImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40)

            Image(systemName: iconImage)
                .foregroundStyle(iconColor)
                .font(.system(size: iconSize, weight: .semibold))
                .offset(y: -5)
        }
        .scaleEffect(isSelected ? 1.5 : 1.0)
        .animation(
            .spring(response: 0.3, dampingFraction: 0.55),
            value: isSelected
        )
    }
}

#Preview("All") {
    ZStack {
        Color.gray.opacity(0.4)

        HStack {
            EventAnnotationView(
                event: TempData.event1,
                viewModel: MapViewModel()
            )
            EventAnnotationView(
                event: TempData.event2,
                viewModel: MapViewModel(),
                isJoined: true
            )
            EventAnnotationView(
                event: TempData.event4,
                viewModel: MapViewModel(),
                isCompleted: true,
                isSelecteds: true
            )
        }
    }.ignoresSafeArea()
}

#Preview("Volleyball - Default") {
    EventAnnotationView(event: TempData.event1, viewModel: MapViewModel())
}

#Preview("Running - Joined") {
    EventAnnotationView(
        event: TempData.event2,
        viewModel: MapViewModel(),
        isJoined: true
    )
}

#Preview("Basketball - Completed") {
    EventAnnotationView(
        event: TempData.event4,
        viewModel: MapViewModel(),
        isCompleted: true
    )
}

#Preview("custom annotation") {
    HStack {
        ZStack {
            Image("map-pin-default")
            Image(systemName: "figure.volleyball")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .semibold))
                .offset(y: -5)
        }
        ZStack {
            Image("map-pin-joined")
            Image(systemName: "figure.volleyball")
                .foregroundStyle(.black)
                .font(.system(size: 20, weight: .semibold))
                .offset(y: -5)
        }
        ZStack {
            Image("map-pin-completed")
            Image(systemName: "figure.volleyball")
                .foregroundStyle(.white)
                .font(.system(size: 20, weight: .semibold))
                .offset(y: -5)
        }
    }
    .frame(width: .infinity, height: .infinity)
    .padding()
    .background(.gray)
}
