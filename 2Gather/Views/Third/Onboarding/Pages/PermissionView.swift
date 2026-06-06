//
//  PermissionView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct PermissionView: View {
    @StateObject private var viewModel = PermissionViewModel(
        permissionService: PermissionService()
    )

    let onContinue: () -> Void

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.white)
            VStack(spacing: 24) {
                Text("Enable Permissions")
                    .font(.displayM)
                    .foregroundColor(.TGprimary)
                Spacer()
                Image(.mascotSkating)
                VStack(alignment: .leading, spacing: 16) {
                    Text("More, more!!!").font(.displayM)
                    Text("Enable the **location** and **camera** access so we can show you the funsies.")
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
                    .foregroundColor(.TGprimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.TGterniary)
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
