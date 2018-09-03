//
//  MyTextField.swift
//  Phonebook
//
//  Created by MArko Satlan on 30/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class MyTextField: UITextField {
// MARK: - Properties
    static let textFieldHeight: CGFloat = 43

// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setLeftPaddingPoints(15)
        autocorrectionType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Methods
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 1, y: 0, width: amount, height: frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func addLeftVerticalSeparator() {
        let separatorView = UIView(frame: CGRect(x: 0, y: 8, width: 1, height: 35))
        separatorView.backgroundColor = UIColor.lightGray
        addSubview(separatorView)
    }
}
