//
//  TGTextField.swift
//  2Gather
//
//  Created by RyanMFDR on 03/06/26.
//
import SwiftUI

// MARK: - Normal Text
struct TGTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.TGprimary.opacity(0.5))

            TextField(placeholder, text: $text)
                .foregroundColor(.TGprimary.opacity(0.5))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.backgroundSecondary)
        .clipShape(Capsule())
    }
}

// MARK: - Secure Text
struct TGSecureField: View {
    let placeholder: String
    @Binding var textPassword: String
    @Binding var isVisible: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "lock")
                .foregroundColor(.gray)

            Group {
                if isVisible {
                    TextField(placeholder, text: $textPassword)
                        .foregroundColor(.TGprimary.opacity(0.5))
                } else {
                    //SecureField
                    SecureField(placeholder, text: $textPassword)
                        .foregroundColor(.TGprimary.opacity(0.5))
                }
            }

            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye" : "eye.slash")
                    .foregroundStyle(Color.TGsecondary)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.backgroundSecondary)
        .clipShape(Capsule())
    }
}

#Preview("Text Field") {
    TGSecureField(
        placeholder: "Password",
        textPassword: .constant(""),
        isVisible: .constant(true)
    )
    .padding()
}
