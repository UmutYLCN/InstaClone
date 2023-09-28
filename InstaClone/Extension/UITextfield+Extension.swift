//
//  UITextfield+Extension.swift
//  InstaClone
//
//  Created by umut yalçın on 27.09.2023.
//

import Foundation
import UIKit


extension UITextField {
    
    func toStyledTxtField() { // Give Round Border and Left Placholder Padding
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        self.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        self.leftViewMode = UITextField.ViewMode.always
    }
}
