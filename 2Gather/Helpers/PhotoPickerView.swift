//
//  PhotoPickerView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 30/05/26.
//

import PhotosUI
import SwiftUI

struct PhotoPickerView: UIViewControllerRepresentable {
    
    var onImagePicked: (UIImage) -> Void
    var onCancel: () -> Void = {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked, onCancel: onCancel)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var onImagePicked: (UIImage) -> Void
        var onCancel: () -> Void
        
        init(onImagePicked: @escaping (UIImage) -> Void, onCancel: @escaping () -> Void) {
            self.onImagePicked = onImagePicked
            self.onCancel = onCancel
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else {
                onCancel()
                return
            }
            
            guard provider.canLoadObject(ofClass: UIImage.self) else {
                onCancel()
                return
            }
            
            provider.loadObject(ofClass: UIImage.self) { object, _ in
                DispatchQueue.main.async {
                    if let image = object as? UIImage {
                        self.onImagePicked(image)
                    }
                }
            }
        }
    }
}
