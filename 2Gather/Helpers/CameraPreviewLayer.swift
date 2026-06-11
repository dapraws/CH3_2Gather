//
//  CameraPreviewLayer.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 30/05/26.
//

import AVFoundation
import SwiftUI

struct CameraPreviewLayer: UIViewRepresentable {
    
    var viewModel: CameraViewModel
    
    func makeUIView(context: Context) -> PreviewView {
        let view = PreviewView()
        view.session = viewModel.session
        return view
    }
    
    func updateUIView(_ uiView: PreviewView, context: Context) {}
}

class PreviewView: UIView {
    
    var session: AVCaptureSession? {
        didSet {
            guard let session else { return }
            let preview = AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = .resizeAspectFill
            preview.frame = bounds
            layer.addSublayer(preview)
            self.previewLayer = preview
        }
    }
    
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        previewLayer?.frame = bounds
    }
}
