//
//  Fonts.swift
//  fetch-xkcd
//
//  Created by Evan Templeton on 12/29/24.
//

import struct SwiftUI.Font
import UIKit

extension Font {
    static var regular12: Font {
        Font.system(size: 12)
    }
    
    static var regular16: Font {
        Font.system(size: 16)
    }
    
    static var helveticaSmallCapsBold16: Font {
        let uiFont = UIFont.systemFont(ofSize: 16).lowercaseAsSmallCaps()
        return Font(uiFont).bold()
    }
    
    static var helveticaSmallCapsBold21: Font {
        let uiFont = UIFont.systemFont(ofSize: 21).lowercaseAsSmallCaps()
        return Font(uiFont).bold()
    }
}

extension UIFont {
    func lowercaseAsSmallCaps() -> UIFont {
        let smallCapsDesc = self.fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.featureSettings: [
                [
                    UIFontDescriptor.FeatureKey.type: kLowerCaseType,
                    UIFontDescriptor.FeatureKey.selector: kUpperCaseSmallCapsSelector
                ]
            ]
        ])
        return UIFont(descriptor: smallCapsDesc, size: self.pointSize)
    }
}
