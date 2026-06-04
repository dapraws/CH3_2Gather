//
//  AccessPageView.swift
//  2Gather
//
//  Created by RyanMFDR on 02/06/26.
//

import SwiftUI

struct AccessPageView: View {
    var body: some View {
        
        VStack(spacing: 111) {
            Spacer()
            Image(.mascotTG3)
            
            VStack(alignment: .leading, spacing:10) {
                Text("More, more!!!")
                    .font(.displayM)
                    .foregroundColor(.TGprimary)
                
                Text("Enable the location and camera access so we can show you the funsies.")
                    .font(.bodyL)
                    .foregroundColor(.TGprimary)
            }
            
            Button(action: {
                //register
            }) {
                Text("Continue")
                    .font(.headingS)
                    .foregroundColor(.TGprimary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.TGterniary)
                    .cornerRadius(30)
            }
            Spacer()
        }.padding(.horizontal, 44)
    }
}

#Preview {
    AccessPageView()
}
