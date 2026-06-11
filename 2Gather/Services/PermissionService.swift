//
//  PermissionService.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import AVFoundation
import CoreLocation
import Foundation
import Photos

@MainActor
final class PermissionService: NSObject, CLLocationManagerDelegate {
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()
    private var locationCompletion: ((Bool) -> Void)?
    
    func requestLocationPermission(completion: @escaping (Bool) -> Void) {
        self.locationCompletion = completion
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = manager.authorizationStatus
        guard status != .notDetermined else { return }
        let granted =
        status == .authorizedWhenInUse || status == .authorizedAlways
        locationCompletion?(granted)
        locationCompletion = nil
    }
    
    func requestCameraPermission(completion: @escaping (Bool) -> Void) {
        AVCaptureDevice.requestAccess(for: .video) { granted in
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }
    
    func requestPhotoPermission(completion: @escaping (Bool) -> Void) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            DispatchQueue.main.async {
                completion(status == .authorized || status == .limited)
            }
        }
    }
}
