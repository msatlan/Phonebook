//
//  ContactNumberCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 20/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

// MARK: - Properties
    let label = UILabel()
    let textField = UITextField()
    let verticalSeparator = UIView()
    
// MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Configure UI / set constraints
    private func configureUI() {
        contentView.addSubview(label)
        
        verticalSeparator.backgroundColor = UIColor.lightGray
        contentView.addSubview(verticalSeparator)
        
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        textField.autocorrectionType = .no
        contentView.addSubview(textField)
        //textField.becomeFirstResponder()
    }
    
    private func setConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: topAnchor),
                                     label.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
                                     label.widthAnchor.constraint(equalToConstant: 100),
                                     label.heightAnchor.constraint(equalTo: heightAnchor)])
        
        verticalSeparator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([verticalSeparator.topAnchor.constraint(equalTo: topAnchor),
                                     verticalSeparator.leftAnchor.constraint(equalTo: label.rightAnchor),
                                     verticalSeparator.widthAnchor.constraint(equalToConstant: 1),
                                     verticalSeparator.heightAnchor.constraint(equalTo: heightAnchor)])
 
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: topAnchor),
                                     textField.leftAnchor.constraint(equalTo: verticalSeparator.rightAnchor, constant: 10),
                                     textField.rightAnchor.constraint(equalTo: rightAnchor),
                                     textField.heightAnchor.constraint(equalTo: heightAnchor)])
    }
}
