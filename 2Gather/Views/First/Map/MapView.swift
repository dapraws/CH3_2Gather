//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import MapKit
import SwiftData
import SwiftUI

struct MapView: View {

    @State private var viewModel = MapViewModel()
    @Namespace private var mapScope

    @Query private var userStates: [UserEventState]

    private var joinedEventIds: Set<UUID> {
        Set(userStates.map { $0.eventId })
    }

    private var displayedEvents: [Event] {
        viewModel.filteredEvents(joinedEventIds: joinedEventIds)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {

                Map(position: $viewModel.position) {
                    UserAnnotation {
                        ZStack {
                            Circle()
                                .fill(.yellow)
                                .strokeBorder(Color.black, lineWidth: 3)
                                .frame(width: 25, height: 25)
                                .shadow(color: .black.opacity(0.68), radius: 8)
                        }
                        .frame(width: 40, height: 40)
                    }

                    ForEach(displayedEvents, id: \.id) { event in
                        Annotation(
                            "",
                            coordinate: CLLocationCoordinate2D(
                                latitude: event.latitude,
                                longitude: event.longitude
                            )
                        ) {

                            let state = userStates.first(where: {
                                $0.eventId == event.id
                            })

                            EventAnnotationView(
                                event: event,
                                viewModel: viewModel,
                                isJoined: state != nil,
                                isCompleted: state?.isCompleted ?? false
                            )
                            .onTapGesture {
                                viewModel.selectAndZoom(event)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                .sheet(
                    item: $viewModel.selectedEvent,
                    onDismiss: { viewModel.deselectEvent() }
                ) { event in
                    EventDetailSheet(event: event)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {

                        FilterChipView(
                            label: "Active",
                            icon: "bolt.fill",
                            color: .blue,
                            isSelected: viewModel.showActiveOnly
                        ) {
                            viewModel.showActiveOnly.toggle()
                            viewModel.zoomToFit(events: displayedEvents)
                        }

                        Divider().frame(height: 20)

                        FilterChipView(
                            label: "All",
                            icon: "square.grid.2x2",
                            color: .gray,
                            isSelected: viewModel.selectedCategory == nil
                                && !viewModel.showActiveOnly
                        ) {
                            viewModel.selectedCategory = nil
                            viewModel.showActiveOnly = false
                            viewModel.zoomToFit(events: viewModel.events)
                        }

                        ForEach(SportCategory.allCases, id: \.self) {
                            category in
                            if category != .other {
                                FilterChipView(
                                    label: category.label,
                                    icon: category.icon,
                                    color: category.color,
                                    isSelected: viewModel.selectedCategory
                                        == category
                                ) {
                                    if viewModel.selectedCategory == category {
                                        viewModel.selectedCategory = nil
                                    } else {
                                        viewModel.selectedCategory = category
                                    }
                                    viewModel.zoomToFit(events: displayedEvents)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, -5)
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    viewModel.centerOnUser()
                } label: {
                    Image(systemName: "location.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.blue, in: Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 0)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search events..."
            )
            .onChange(of: viewModel.searchText) { _, _ in
                viewModel.zoomToFit(events: displayedEvents)
            }
        }
        .onAppear {
            viewModel.locationManager.requestPermission()
            viewModel.locationManager.startUpdating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.centerOnUser()
            }
        }
    }
}

#Preview {
    MapView()
}
