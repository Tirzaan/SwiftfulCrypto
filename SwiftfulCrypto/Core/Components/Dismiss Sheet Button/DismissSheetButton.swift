//
//  DismissSheetButtonView.swift
//  SwiftfulCrypto
//
//  Created by Tirzaan on 8/28/25.
//

import SwiftUI

struct DismissSheetButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.headline)
        }
    }
}

#Preview {
    DismissSheetButton()
}
