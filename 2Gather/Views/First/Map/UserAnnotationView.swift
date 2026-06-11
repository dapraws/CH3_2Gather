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
                .fill(Color.TGBrown)
                .frame(width: 26, height: 26)
                .shadow(
                    color: Color.TGBrown.opacity(0.68),
                    radius: 8,
                )
            Circle()
                .fill(Color.TGYellow)
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
