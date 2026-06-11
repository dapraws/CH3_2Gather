//
//  LocationManager.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 29/05/26.
//

import CoreLocation
import SwiftUI

@Observable
class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var userLocation: CLLocation?
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var permissionDenied: Bool = false
    private let manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    func startUpdating() {
        manager.startUpdatingLocation()
    }
    
    func isWithinRadius(of event: Event, meters: Double = 500) -> Bool {
        guard let userLocation else { return false }
        let eventLocation = CLLocation(
            latitude: event.latitude,
            longitude: event.longitude
        )
        return userLocation.distance(from: eventLocation) <= meters
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            permissionDenied = false
            manager.startUpdatingLocation()
        case .denied, .restricted:
            permissionDenied = true
        default:
            break
        }
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        userLocation = locations.last
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("LocationManager error: \(error.localizedDescription)")
    }
}
