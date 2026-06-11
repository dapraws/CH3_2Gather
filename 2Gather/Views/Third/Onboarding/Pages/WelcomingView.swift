//
//  WelcomingView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI
import Lottie

struct WelcomingView: View {
    let onGetStarted: () -> Void
    let onSignIn: () -> Void
    
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some View {
        ZStack {
            Color.TGWhite
                .ignoresSafeArea()
            
            VStack (spacing:0) {
                Spacer()
                
                LottieView(animation: .named("animation-mascot-running"))
                    .playing()
                    .looping()
                    .resizable()
                    .frame(width: 300, height: 300)
                    .padding(-40)
                    .padding(.trailing, 10)
                
                Image(.applightSlogan)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                Spacer()
                Spacer()
            }
        }
        .overlay(alignment: .bottom){
            Button {
                onGetStarted()
            } label: {
                Text("Let's get started!")
                    .font(.headingS)
                    .foregroundColor(.TGBrown)
                    .frame(width: 300)
                    .padding(.vertical, 15)
                    .background(Color.TGYellow)
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
