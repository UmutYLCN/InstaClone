//
//  setBorder.swift
//  InstaClone
//
//  Created by umut yalçın on 27.09.2023.
//

import Foundation
import UIKit

extension UIView {
    func setBorder(width: CGFloat, color: UIColor) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
}

