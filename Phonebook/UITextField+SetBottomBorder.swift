//
//  UITextField+SetBottomBorder.swift
//  Phonebook
//
//  Created by MArko Satlan on 29/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

extension UITextField {
    func setBottomBorder(withColor color: UIColor) {
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        let width: CGFloat = 1.0
        
        let borderLine = UIView(frame: CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width))
        borderLine.backgroundColor = color
        self.addSubview(borderLine)
    }
}

