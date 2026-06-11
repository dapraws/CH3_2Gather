//
//  ButtonStyles.swift
//  2Gather
//
//  Created by Eunice Santos on 07/06/26.
//


import SwiftUI

struct TGWhiteButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white)
            .foregroundColor(Color.TGBrown.opacity(configuration.isPressed ? 0.7 : 1.0))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .font(.headingS)
            
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}


struct TGPrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.TGBrownToYellow.opacity(configuration.isPressed ? 0.8 : 1.0))
            .foregroundColor(.TGWhiteToBrown )
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct TGSecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, minHeight: 50)
            .background(Color.TGBrownToOrange.opacity(configuration.isPressed ? 0.8 : 1.0))
            .foregroundColor(.TGWhite)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct TGShareBannerButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.labelM)
            .frame(maxWidth: .infinity, minHeight: 36)
            .background(Color.TGBrown.opacity(configuration.isPressed ? 0.8 : 1.0))
            .foregroundColor(Color.TGYellow)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.1), value: configuration.isPressed)
    }
}

#Preview("Button Styles Preview") {
    VStack(spacing: 32) {
        
        VStack(spacing: 8) {
            Text("White Button Style")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                print("White button tapped")
            }) {
                Text("Daftar Sekarang")
            }
            .buttonStyle(TGWhiteButtonStyle())
        }
        
        VStack(spacing: 8) {
            Text("Primary Button Style")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                print("Primary button tapped")
            }) {
                Text("Masuk")
            }
            .buttonStyle(TGPrimaryButtonStyle())
        }
        
        VStack(spacing: 8) {
            Text("White Button Style")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                print("White button tapped")
            }) {
                Text("KEDUAAAA")
            }
            .buttonStyle(TGSecondaryButtonStyle())
        }
        
        VStack(spacing: 8) {
            Text("Share Banner Button Style")
                .font(.caption)
                .foregroundColor(.gray)
            
            Button(action: {
                print("Share button tapped")
            }) {
                Text("Bagikan ke Teman")
            }
            .buttonStyle(TGShareBannerButtonStyle())
        }
        
    }
    .padding()
    // Memberikan warna background sedikit gelap agar tombol putih terlihat kontras
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.opacity(0.05))
}
