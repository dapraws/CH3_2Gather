//
//  CameraViewModel.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 30/05/26.
//

import AVFoundation
import Combine
import SwiftUI

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var photoData: Data? = nil
    @Published var isFlashOn = false
    
    private var output = AVCapturePhotoOutput()
    private var isFrontCamera = false
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setup()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { status in
                if status { self.setup() }
            }
        case .denied:
            alert = true
        default:
            return
        }
    }
    
    func setup() {
        DispatchQueue.global(qos: .userInitiated).async {
            do {
                self.session.beginConfiguration()
                
                guard let device = AVCaptureDevice.default(
                    .builtInWideAngleCamera,
                    for: .video,
                    position: .back
                ) else { return }
                
                let input = try AVCaptureDeviceInput(device: device)
                if self.session.canAddInput(input) { self.session.addInput(input) }
                if self.session.canAddOutput(self.output) { self.session.addOutput(self.output) }
                
                self.session.commitConfiguration()
                self.session.startRunning()
                
            } catch {
                print("Camera setup error: \(error.localizedDescription)")
            }
        }
    }
    
    func takePic() {
        let settings = AVCapturePhotoSettings()
        settings.flashMode = isFlashOn ? .on : .off
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error { print(error.localizedDescription); return }
        guard let data = photo.fileDataRepresentation() else { return }
        DispatchQueue.main.async {
            self.photoData = data
        }
    }
    
    func toggleFlash() {
        isFlashOn.toggle()
    }
    
    func flipCamera() {
        session.beginConfiguration()
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        session.removeInput(currentInput)
        
        isFrontCamera.toggle()
        let newPosition: AVCaptureDevice.Position = isFrontCamera ? .front : .back
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition) else { return }
        do {
            let newInput = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(newInput) { session.addInput(newInput) }
        } catch {
            print(error.localizedDescription)
        }
        session.commitConfiguration()
    }
}
