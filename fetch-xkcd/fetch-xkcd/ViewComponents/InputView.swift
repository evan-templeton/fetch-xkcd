//
//  InputView.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

/**
 
 __Explanation of Choices
 
 - Apple's built in TextField doesn't provide much in the way of customization.
 - This implementation is a stripped down version of one I built a couple years ago. It adds a movable, customizable placeholder view, along with a customizable icon.
 
 */

import SwiftUI

struct InputView: View {
    @Binding var value: Int?
    let placeholder: String
    let image: Image
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack {
                    image
                        .font(.regular16)
                    VStack(alignment: .leading, spacing: 5) {
                        if value != nil {
                            Text(placeholder)
                                .font(.regular12)
                                .foregroundColor(.gray6)
                                .fixedSize()
                                .accessibilityIdentifier("searchInputUpperPlaceholder")
                        }
                        TextField(value: $value, formatter: NumberFormatter(), label: {})
                            .multilineTextAlignment(.leading)
                            .accessibilityIdentifier("searchInputField")
                            .placeholder(when: value == nil, alignment: .topLeading) {
                                Text(placeholder)
                                    .font(.regular16)
                                    .foregroundColor(.gray6)
                                    .accessibilityIdentifier("searchInputMainPlaceholder")
                            }
                            .font(.regular16)
                    }
                    Spacer()
                }
                .padding(.vertical, value != nil ? 5 : 15)
                Divider()
                    .background(Color.gray5)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

private extension View {
    func placeholder<Content: View>(when shouldShow: Bool,
                                    alignment: Alignment = .leading,
                                    @ViewBuilder placeholder: () -> Content) -> some View {
        
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0).fixedSize()
            self
        }
    }
}

#Preview {
    ContentView()
}
