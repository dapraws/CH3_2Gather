//
//  MapViewModel.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import MapKit
import SwiftUI

@Observable
class MapViewModel {
    
    var events: [Event] = TempData.allEvents
    var selectedEvent: Event? = nil
    var highlightedEventId: UUID? = nil
    var searchText: String = ""
    var selectedCategory: SportCategory? = nil
    var showActiveOnly: Bool = false
    var locationManager = LocationManager()
    
    var position: MapCameraPosition = .region(
        MKCoordinateRegion()
    )
    
    func centerOnUser() {
        guard let loc = locationManager.userLocation else { return }
        position = .region(
            MKCoordinateRegion(
                center: loc.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
            )
        )
    }
    
    func selectEvent(_ event: Event) {
        highlightedEventId = event.id
        selectedEvent = event
    }
    
    func deselectEvent() {
        highlightedEventId = nil
        selectedEvent = nil
    }
    
    func filteredEvents(joinedEventIds: Set<UUID>) -> [Event] {
        events.filter { event in
            let matchesSearch = searchText.isEmpty || event.name.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory: Bool
            if let selected = selectedCategory {
                matchesCategory = SportCategory.from(categories: event.category) == selected
            } else {
                matchesCategory = true
            }
            
            let matchesActive = showActiveOnly ? joinedEventIds.contains(event.id) : true
            
            return matchesSearch && matchesCategory && matchesActive
        }
    }
    
    func zoomToFit(events: [Event]) {
        guard !events.isEmpty else { return }
        var rect = MKMapRect.null
        
        for event in events {
            let point = MKMapPoint(CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude))
            let pointRect = MKMapRect(x: point.x, y: point.y, width: 0, height: 0)
            rect = rect.isNull ? pointRect : rect.union(pointRect)
        }
        
        let paddedRect = MKMapRect(
            x: rect.origin.x - (rect.size.width * 0.2),
            y: rect.origin.y - (rect.size.height * 0.2),
            width: rect.size.width * 1.4,
            height: rect.size.height * 1.4
        )
        
        withAnimation(.easeInOut(duration: 0.5)) {
            if rect.width < 1000 {
                self.position = .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: events.first!.latitude, longitude: events.first!.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                ))
            } else {
                self.position = .rect(paddedRect)
            }
        }
    }
    
    func selectAndZoom(_ event: Event) {
        highlightedEventId = event.id
        selectedEvent = event
        withAnimation(.easeInOut(duration: 0.4)) {
            position = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: event.latitude, longitude: event.longitude),
                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                )
            )
        }
    }
}
