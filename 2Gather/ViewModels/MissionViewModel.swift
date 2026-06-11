//
//  MissionViewModel.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import SwiftUI

@Observable
class MissionViewModel {
    
    var showCamera = false
    var showPreview = false
    var capturedImage: UIImage? = nil
    
    func didCapture(_ image: UIImage) {
        capturedImage = image
        showCamera = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showPreview = true
        }
    }
    
    func retake() {
        showPreview = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.showCamera = true
        }
    }
    
    func submitProof(
        image: UIImage,
        caption: String,
        mission: Mission,
        eventState: UserEventState?,
        onComplete: (String) -> Void
    ) {
        if let fileName = PhotoStorage.saveProofImage(image, for: mission.id) {
            //            print("✅ Photo saved: \(fileName)") // debug
            eventState?.proofImagePath = fileName
            eventState?.proofImagePath = fileName
            eventState?.caption = caption
            eventState?.isCompleted = true
            onComplete(mission.reward)
        } else {
            //            print("❌ Photo save failed") // debug
        }
        showPreview = false
    }
}
