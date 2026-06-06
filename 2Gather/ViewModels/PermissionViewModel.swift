//
//  PermissionViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import Combine

@MainActor
final class PermissionViewModel: ObservableObject {
    @Published var isRequestingPermission = false
    @Published var errorMessage: String?
    private let permissionService: PermissionService

    init(permissionService: PermissionService) {
        self.permissionService = permissionService
    }

    func requestRequiredPermissions(completion: @escaping () -> Void) {
        isRequestingPermission = true
        errorMessage = nil

        permissionService.requestLocationPermission { [weak self] _ in
            self?.permissionService.requestCameraPermission { [weak self] _ in
                self?.isRequestingPermission = false
                completion()
            }
        }
    }
}
