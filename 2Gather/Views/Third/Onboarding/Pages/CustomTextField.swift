//
//  TGTextField.swift
//  2Gather
//
//  Created by RyanMFDR on 03/06/26.
//
import SwiftUI

struct CustomTextField: View {
    let placeholder: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.gray)
            
            TextField(placeholder, text: $text)
                .foregroundColor(.black.opacity(0.5))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.TGFWhite)
        .clipShape(Capsule())
    }
}


struct CustomSecureField: View {
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
                        .foregroundColor(.black.opacity(0.5))
                } else {
                    //SecureField
                    SecureField(placeholder, text: $textPassword)
                        .foregroundColor(.black.opacity(0.5))
                }
            }
            
            Button {
                isVisible.toggle()
            } label: {
                Image(systemName: isVisible ? "eye" : "eye.slash")
                    .foregroundStyle(Color.TGOrange)
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 24)
        .background(Color.TGFWhite)
        .clipShape(Capsule())
    }
}

#Preview("Text Field") {
    VStack {
        CustomTextField(
            placeholder: "Email",
            text: .constant(""),
            icon: "envelope"
        )
        CustomSecureField(
            placeholder: "Password",
            textPassword: .constant(""),
            isVisible: .constant(true)
        )
    }
    .padding()
    .withPreviewEnvironment()
}
