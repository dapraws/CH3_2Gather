//
//  UserAnnotationView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 03/06/26.
//

import MapKit
import SwiftUI

struct UserAnnotationView: View {
    
    @State private var isBreathing = false
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.TGprimary)
                .frame(width: 26, height: 26)
                .shadow(
                    color: Color.TGprimary.opacity(0.68),
                    radius: 8,
                    y: -5
                )
            Circle()
                .fill(Color.TGterniary)
                .frame(width: 20, height: 20)
                .scaleEffect(isBreathing ? 0.85 : 1.0)
                .animation(
                    .easeInOut(duration: 2)
                        .repeatForever(autoreverses: true),
                    value: isBreathing
                )
                .onAppear {
                    isBreathing = true
                }
        }
        .frame(width: 40, height: 40)

    }
}

#Preview {
    UserAnnotationView()
}
