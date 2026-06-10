//
//  PermissionView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI
import Lottie

struct PermissionView: View {
    @StateObject private var viewModel = PermissionViewModel(
        permissionService: PermissionService()
    )

    let onContinue: () -> Void

    var body: some View {
        ZStack {
            Color.TGWhite
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                Text("Enable Permissions")
                    .font(.displayM)
                    .foregroundColor(.TGBrown)
                
                LottieView(animation: .named("animation-mascot-skating"))
                    .playing()
                    .looping()
                    .frame(width: 280, height: 280)
                    .padding(.bottom, -35)
                    .padding(.trailing, 5)
        
                VStack(alignment: .leading, spacing: 16) {
                    Text("More, more!!!").font(.displayM)
                        .foregroundColor(.TGBrown)
                    Text("Enable the **location** and **camera** access so we can show you the funsies.")
                        .foregroundColor(.TGBrown)
                }
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                Spacer()
                Spacer()
                Spacer()
            }
            .padding(.top, 40)
            .padding()
            .overlay(alignment: .bottom) {
                Button {
                    viewModel.requestRequiredPermissions {
                        onContinue()
                    }
                } label: {
                    Text(
                        viewModel.isRequestingPermission
                            ? "Loading..." : "Enable access"
                    )
                    .font(.headingS)
                    .foregroundColor(.TGBrown)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.TGYellow)
                    .cornerRadius(19)
                }
                .disabled(viewModel.isRequestingPermission)
            }
            .padding(.bottom, 50)
        }

    }
}

#Preview {
    PermissionView(
        onContinue: {}
    )
}
