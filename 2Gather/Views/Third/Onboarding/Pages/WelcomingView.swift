//
//  WelcomingView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct WelcomingView: View {
    let onGetStarted: () -> Void
    let onSignIn: () -> Void

    var body: some View {
        VStack {
            Spacer()
            Image(.mascotRunningLarge)
            Image(.appSlogan)
            Spacer()
            Spacer()
        }
        .overlay(alignment: .bottom){
            Button {
                onGetStarted()
            } label: {
                Text("Let's get started!")
                    .font(.headingS)
                    .foregroundColor(.TGprimary)
                    .frame(maxWidth: 250)
                    .padding(.vertical, 15)
                    .background(Color.TGterniary)
                    .clipShape(Capsule())
            }
            .padding(.bottom, 50)
        }
    }
}

#Preview {
    WelcomingView(
        onGetStarted: {},
        onSignIn: {}
    )
}
