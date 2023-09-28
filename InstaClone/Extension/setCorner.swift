//
//  setCorner.swift
//  InstaClone
//
//  Created by umut yalçın on 27.09.2023.
//

import Foundation
import UIKit

extension UIView {
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
}
