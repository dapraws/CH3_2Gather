//
//  TextSize.swift
//  2Gather
//
//  Created by Andhika Satria on 02/06/26.
//

import SwiftUI
//import Lottie

struct TextSizeView: View {
    @Environment(\.dismiss) private var dismiss
    
    @State private var sliderValue: Double = 3
    
    private let dynamicTypeSizes: [DynamicTypeSize] = [
        .xSmall, .small, .medium, .large, .xLarge, .xxLarge, .xxxLarge
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // MARK: - 1. Custom Navigation Bar
            HStack {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 44, height: 44)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.05), radius: 8, x: 0, y: 4)
                }
                
                Spacer()
                
                Text("Text Size")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Color.clear.frame(width: 44, height: 44)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 16)
            
            // MARK: - 2. Text Preview Card
            ZStack {
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color.white)
                RoundedRectangle(cornerRadius: 24)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 4)
                
                Text("If you can read this, then this is a good text size for you!")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)
                    .padding(.horizontal, 32)
                    .dynamicTypeSize(dynamicTypeSizes[Int(sliderValue)])
            }
            .frame(maxHeight: .infinity)
            .padding(.horizontal, 24)
            .padding(.top, 8)
            
            // MARK: - 3. Mascot Image
            Image("LargerText")
                .resizable()
                .scaledToFit()
                .frame(height: 100)
                .offset(x: -15)
                .foregroundColor(Color.TGsecondary)
                .padding(.vertical, 32)
            
            // MARK: - 4. Custom Slider Section
            VStack(spacing: 16) {
                HStack(spacing: 16) {
                    Text("Aa")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.gray)
                    
                    ZStack {
                        HStack {
                            ForEach(0..<7) { index in
                                Circle()
                                    .fill(Color(UIColor.systemGray4))
                                    .frame(width: 4, height: 4)
                                
                                if index < 6 { Spacer() }
                            }
                        }
                        .padding(.horizontal, 6)
                        .offset(y: 12)
                        Slider(value: $sliderValue, in: 0...6, step: 1)
                            .tint(Color.TGsecondary)
                    }
                    
                    Text("AA")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 24)
                
                Divider()
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)
            }
        }
        .background(Color(UIColor.secondarySystemGroupedBackground))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TextSizeView()
}
