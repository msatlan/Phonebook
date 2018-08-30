//
//  Section0TableViewCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 29/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class Section0TableViewCell: UITableViewCell {
// MARK: - Properties
    let photoButton = UIButton()
    let firstNameTextField = UITextField()
    let lastNameTextField = UITextField()
    let companyTextField = UITextField()
    
// MARK: - Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure UI / set constraints
    func configureUI() {
        let photoButtonSide: CGFloat = 60
        photoButton.layer.cornerRadius = photoButtonSide / 2
        photoButton.setTitle("Add Photo", for: .normal)
        photoButton.titleLabel?.font = UIFont(name: "AlNile", size: 13)
        photoButton.backgroundColor = UIColor.blue
        contentView.addSubview(photoButton)
        
        let textFieldHeight: CGFloat = 44
        let horizontalSpacing: CGFloat = 10
        
        //firstNameTextField.backgroundColor = UIColor.gray
        firstNameTextField.placeholder = "First Name"
        contentView.addSubview(firstNameTextField)
        
        //lastNameTextField.backgroundColor = UIColor.red
        lastNameTextField.placeholder = "Last Name"
        contentView.addSubview(lastNameTextField)
        
        //companyTextField.backgroundColor = UIColor.brown
        companyTextField.placeholder = "Company"
        contentView.addSubview(companyTextField)
        
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([photoButton.topAnchor.constraint(equalTo: topAnchor, constant: 36),
                                     photoButton.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalSpacing),
                                     photoButton.widthAnchor.constraint(equalToConstant: photoButtonSide),
                                     photoButton.heightAnchor.constraint(equalToConstant: photoButtonSide)])
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([firstNameTextField.topAnchor.constraint(equalTo: topAnchor),
                                     firstNameTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     firstNameTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     firstNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)])
        
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor),
                                     lastNameTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     lastNameTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     lastNameTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)])
        
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([companyTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor),
                                     companyTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     companyTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     companyTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)])
    }
}
