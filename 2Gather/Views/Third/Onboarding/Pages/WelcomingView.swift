//
//  WelcomingView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct WelcomingView: View {
    var onGetStarted: () -> Void
    var onSignIn: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(.mascotTG)
            Image(.appnameWithSlogan)
            
            Spacer()

            VStack(spacing:10) {
                Button {
                    onGetStarted()
                } label: {
                    Text("Let's get started!")
                        .padding(.horizontal, 42)
                        .padding(.vertical, 8)
                        .font(.headingS)
                        .foregroundStyle(Color.TGprimary)
                        .background(Color.TGterniary)
                        .clipShape(Capsule())
                }
                Button {
                    onSignIn()
                } label: {
                    Text("I already have an account")
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundStyle(Color.TGprimary)
                        .overlay(RoundedRectangle(cornerRadius: 19).stroke(Color.TGprimary, lineWidth: 1))
                }
            }
            Spacer()

        }
    }
}

#Preview {
    WelcomingView(onGetStarted: {}, onSignIn: {})
}
