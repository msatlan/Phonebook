//
//  Section0TableViewCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 29/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

protocol Section0TableViewCellDelagate: class {
    func firstNameTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String)
    func lastNameTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String)
    func companyTextFieldDidEndEditing(_ tableViewCell: Section0TableViewCell, text: String)
}

class Section0TableViewCell: UITableViewCell {
// MARK: - Properties
    let photoButton = UIButton()
    let firstNameTextField = MyTextField()
    let lastNameTextField = MyTextField()
    let companyTextField = MyTextField()
    
    weak var delegate: Section0TableViewCellDelagate?
    
    private let photoButtonSide: CGFloat = 60
    private let separator1 = UIView()
    private let separator2 = UIView()
    private let separator3 = UIView()
    
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
    func configureUI() {
        // Button
        photoButton.layer.cornerRadius = photoButtonSide / 2
        photoButton.setTitle("Add Photo", for: .normal)
        photoButton.titleLabel?.font = UIFont(name: "AlNile", size: 13)
        photoButton.backgroundColor = UIColor.blue
        contentView.addSubview(photoButton)
        
        // TextFields
        firstNameTextField.placeholder = "First Name"
        firstNameTextField.setLeftPaddingPoints(15)
        firstNameTextField.setBottomBorder()
        firstNameTextField.delegate = self
        firstNameTextField.tag = 100
        contentView.addSubview(firstNameTextField)
        
        lastNameTextField.placeholder = "Last Name"
        lastNameTextField.setLeftPaddingPoints(15)
        lastNameTextField.setBottomBorder()
        lastNameTextField.delegate = self
        lastNameTextField.tag = 101
        contentView.addSubview(lastNameTextField)
        
        companyTextField.placeholder = "Company"
        companyTextField.setLeftPaddingPoints(15)
        companyTextField.setBottomBorder()
        companyTextField.delegate = self
        companyTextField.tag = 102
        contentView.addSubview(companyTextField)
    }
        
    func setConstraints() {
        let horizontalSpacing: CGFloat = 10
        
        photoButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([photoButton.topAnchor.constraint(equalTo: topAnchor, constant: 36),
                                     photoButton.leftAnchor.constraint(equalTo: leftAnchor, constant: horizontalSpacing),
                                     photoButton.widthAnchor.constraint(equalToConstant: photoButtonSide),
                                     photoButton.heightAnchor.constraint(equalToConstant: photoButtonSide)])
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([firstNameTextField.topAnchor.constraint(equalTo: topAnchor),
                                     firstNameTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     firstNameTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     firstNameTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
 
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 2),
                                     lastNameTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     lastNameTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     lastNameTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
        
        companyTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([companyTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 2),
                                     companyTextField.leftAnchor.constraint(equalTo: photoButton.rightAnchor, constant: horizontalSpacing),
                                     companyTextField.rightAnchor.constraint(equalTo: rightAnchor),
                                     companyTextField.heightAnchor.constraint(equalToConstant: MyTextField.textFieldHeight)])
    }
}

extension Section0TableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        var unwrappedText: String
        
        switch textField.tag {
        case 100:
            if let text = textField.text {
                unwrappedText = text
                delegate?.firstNameTextFieldDidEndEditing(self, text: unwrappedText)
            }
        case 101:
            if let text = textField.text {
                unwrappedText = text
                delegate?.lastNameTextFieldDidEndEditing(self, text: unwrappedText)
            }
        case 102:
            if let text = textField.text {
                unwrappedText = text
                delegate?.companyTextFieldDidEndEditing(self, text: unwrappedText)
            }
        default: break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
