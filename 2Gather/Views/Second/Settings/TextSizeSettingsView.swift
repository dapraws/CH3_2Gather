//
//  TextSizeSettingsView.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftUI

struct TextSizeSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var textSizeManager = TextSizeManager.shared
    
    @State private var sliderValue: Double = Double(
        TextSizeManager.shared.currentScale.index
    )
    
    private let fontSizes: [CGFloat] = [13, 17, 21]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 2. Text Preview Card
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.TGWhiteToSGreen)
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                
                Text(
                    "If you can read this, then this is a good text size for you!"
                )
                .font(.system(size: textSizeManager.scaled(17)))
                .multilineTextAlignment(.center)
                .foregroundColor(.TGBrownToWhite)
                .padding(.horizontal, 32)
                .animation(
                    .easeInOut(duration: 0.25),
                    value: textSizeManager.currentScale.multiplier
                )
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 24)
            .padding(.top, 8)
            
            // MARK: - 3. Mascot Image
            Image("mascot-looking-new")
                .resizable()
                .scaledToFit()
                .frame(height: textSizeManager.scaled(100))
                .offset(x: -25)
                .padding(.vertical, 32)
            
            // MARK: - 4. Slider
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Image(systemName: "textformat")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    
                    ZStack {
                        HStack {
                            ForEach(0..<3) { index in
                                Circle()
                                    .fill(
                                        index
                                        == textSizeManager.currentScale
                                            .index
                                        ? Color.TGOrange
                                        : Color(UIColor.systemGray4)
                                    )
                                    .frame(width: 4, height: 4)
                                
                                if index < 2 { Spacer() }
                            }
                        }
                        .padding(.horizontal, 6)
                        .offset(y: 12)
                        
                        Slider(value: $sliderValue, in: 0...2, step: 1)
                            .tint(Color.TGOrange)
                            .onChange(of: sliderValue) { _, newValue in
                                let scale = FontScale.from(index: Int(newValue))
                                textSizeManager.setScale(scale)
                                UIImpactFeedbackGenerator(style: .light)
                                    .impactOccurred()
                            }
                    }
                    
                    Image(systemName: "textformat")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                
                Divider()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .background(Color.TGFWhiteToDGreen)
        .navigationTitle("Text Size")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        TextSizeSettingsView()
    }
    .withPreviewEnvironment()
}
