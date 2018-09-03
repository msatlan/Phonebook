//
//  ContactNumberCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 20/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

protocol CustomTableViewCellDelegate: class {
    func buttonTapped(_ tableViewCell: CustomTableViewCell)
}

class CustomTableViewCell: UITableViewCell {

// MARK: - Properties
    let button = UIButton()
    let textField = MyTextField()
    weak var delegate: CustomTableViewCellDelegate?
    
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
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        contentView.addSubview(button)
        
        textField.placeholder = "Phone"
        textField.keyboardType = .numberPad
        textField.addLeftVerticalSeparator()
        textField.becomeFirstResponder()
        contentView.addSubview(textField)
    }
    
    private func setConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([button.topAnchor.constraint(equalTo: topAnchor),
                                     button.leftAnchor.constraint(equalTo: leftAnchor, constant: 45),
                                     button.widthAnchor.constraint(equalToConstant: 105),
                                     button.heightAnchor.constraint(equalTo: heightAnchor)])
    
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([textField.topAnchor.constraint(equalTo: topAnchor),
                                     textField.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 10),
                                     textField.rightAnchor.constraint(equalTo: rightAnchor),
                                     textField.heightAnchor.constraint(equalTo: heightAnchor)])
    }
    
// MARK: - Action methods
    @objc func buttonTapped(sender: UIButton) {
        delegate?.buttonTapped(self)
    }
}
