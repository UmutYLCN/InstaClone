//
//  circleCorner.swift
//  InstaClone
//
//  Created by umut yalçın on 27.09.2023.
//

import Foundation
import UIKit

extension UIView {
  func circleCorner() {
        superview?.layoutIfNeeded()
        setCorner(radius: frame.height / 2)
    }
}
