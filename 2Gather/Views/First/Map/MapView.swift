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
    @Environment(\.colorScheme) var colorScheme

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
                        UserAnnotationView()
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
                            isSelected: viewModel.showActiveOnly
                        ) {
                            viewModel.showActiveOnly.toggle()
                            viewModel.zoomToFit(events: displayedEvents)
                        }

                        Divider().frame(height: 20)

                        FilterChipView(
                            label: "All",
                            icon: "square.grid.2x2",
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
                        .foregroundStyle(Color.TGprimary)
                        .padding(12)
                        .background(Color.TGterniary, in: Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 0)

                .navigationTitle("Explore")
                //            .toolbar {
                ////                ToolbarItem(placement: .principal) {
                ////                    Image(colorScheme == .dark ? "logo-dark" : "logo-light")
                ////                        .resizable().frame(
                ////                            width: 120,
                ////                            height: 40
                ////                        )
                ////                }
                //            }
                .navigationBarTitleDisplayMode(.large)
                .searchable(
                    text: $viewModel.searchText,
                    placement: .navigationBarDrawer(displayMode: .always),
                    prompt: "Search events..."
                )
                .ignoresSafeArea(edges: .top)
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
}

#Preview {
    MapView()
}
