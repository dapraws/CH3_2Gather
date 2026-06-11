//
//  PreviewHelper.swift
//  2Gather
//
//  Created by Andhika Satria on 11/06/26.
//

import SwiftUI

extension View {
    func withPreviewEnvironment() -> some View {
        self
            .environmentObject(AppSession())
            .environmentObject(TextSizeManager.shared)
    }
}
