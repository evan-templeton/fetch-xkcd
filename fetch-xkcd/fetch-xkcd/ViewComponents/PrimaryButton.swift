//
//  PrimaryButton.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/30/24.
//

import SwiftUI

struct PrimaryButton: View {
    let text: String
    let handler: () -> Void
    
    var body: some View {
        Button(action: handler) {
            Text(text)
                .font(.helveticaSmallCapsBold16)
                .padding(.vertical, 15)
                .frame(maxWidth: .infinity)
                .background(.blue)
                .cornerRadius(10)
                .foregroundColor(.white)
        }
    }
}
