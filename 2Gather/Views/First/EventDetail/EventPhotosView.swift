//
//  EventPhotosView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventPhotoView: View {
    var photoPath: String?
    
    var body: some View {
        
        if photoPath != nil {
            if let path = photoPath {
                Image(path)
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: 220)
                    .clipped()
            }
        } else {
            Rectangle()
                .fill(Color.gray.opacity(0.15))
                .frame(maxWidth: .infinity)
                .frame(height: 220)
                .overlay(
                    VStack(spacing: 8) {
                        Image(systemName: "photo")
                            .foregroundStyle(.gray)
                            .font(.largeTitle)
                        Text("No photo")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                )
        }
    }
}

#Preview("With Photo") {
    EventPhotoView(photoPath: "some_path")
    .withPreviewEnvironment()
}

#Preview("No Photo") {
    EventPhotoView(photoPath: nil)
    .withPreviewEnvironment()
}
