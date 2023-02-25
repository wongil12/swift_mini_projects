//
//  UIViewController+Extension.swift
//  InstagramClone
//
//  Created by Bob on 2023/02/25.
//

import UIKit

extension UIViewController {
    func generateButtonAttribute(_ button: UIButton, texts: String..., fonts: UIFont..., colors: UIColor...) -> NSMutableAttributedString {
        guard let wholeText = button.titleLabel?.text else {fatalError("No text in button")}
        
        let customFonts:[UIFont] = fonts
        
        let customTextRanges = texts.indices.map {index in
            (wholeText as NSString).range(of: texts[index])
        }
        
        let customColors = colors
        
        let attributedString = NSMutableAttributedString(string: wholeText)
        
        texts.indices.forEach { index in
            attributedString.addAttribute(.font, value: customFonts[index], range: customTextRanges[index])
            attributedString.addAttribute(.foregroundColor, value: customColors[index], range: customTextRanges[index])
        }
        return attributedString
    }
}
