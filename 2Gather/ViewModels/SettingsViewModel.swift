//
//  SettingsViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 05/06/26.
//

import SwiftUI
import SwiftData
import PhotosUI

@Observable
final class SettingsViewModel {
    
    var isDarkMode: Bool {
        get { UserDefaults.standard.bool(forKey: "isDarkMode") }
        set { UserDefaults.standard.set(newValue, forKey: "isDarkMode") }
    }
    
    var selectedPhotoItem: PhotosPickerItem? = nil
    var profileImage: UIImage? = nil
    
    var searchText: String = ""
    
    var filteredSports: [Sport] {
        if searchText.isEmpty {
            return SportsCatalog.all
        } else {
            return SportsCatalog.all.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func loadProfileImage(from path: String?) {
        guard let path else {
            profileImage = nil
            return
        }
        profileImage = PhotoStorage.loadProfileImage(named: path)
    }
    
    func handlePhotoSelection(item: PhotosPickerItem?, account: Account?, modelContext: ModelContext) {
        guard let item else { return }
        
        Task {
            guard let data = try? await item.loadTransferable(type: Data.self),
                  let image = UIImage(data: data),
                  let account
            else { return }
            
            if let fileName = PhotoStorage.saveProfileImage(image, for: account.id) {
                await MainActor.run {
                    account.profilePhoto = fileName
                    try? modelContext.save()
                    profileImage = PhotoStorage.loadProfileImage(named: fileName)
                }
            }
        }
    }
    
    func toggleSport(_ sport: Sport, account: Account?, modelContext: ModelContext) {
        guard let account else { return }
        
        var ids = account.preferenceSportIDs
        if ids.contains(sport.id) {
            ids.removeAll { $0 == sport.id }
        } else {
            ids.append(sport.id)
        }
        account.preferenceSportIDs = ids
        try? modelContext.save()
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
    }
}
