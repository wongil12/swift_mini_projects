//
//  UIView+Extension.swift
//  InstagramClone
//
//  Created by Bob on 2023/02/25.
//

import UIKit

extension UIView {
    @IBInspectable var corderRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
}
