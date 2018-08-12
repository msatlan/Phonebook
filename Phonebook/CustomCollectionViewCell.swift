//
//  CustomCollectionViewCell.swift
//  Phonebook
//
//  Created by MArko Satlan on 08/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
// MARK: - Properties
    static let cellSize = CGSize(width: 100, height: 100)
    let imageView = UIImageView()
    let firstNameLabel = UILabel()
    let lastNameLabel = UILabel()

// MARK: - Methods
    // Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }
    
    func configure(for contact: Contact) {
        firstNameLabel.text = contact.firstName
        lastNameLabel.text = contact.lastName
    }
    
    func configureUI() {
        backgroundColor = UIColor.lightGray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        firstNameLabel.backgroundColor = UIColor.white
        firstNameLabel.font = UIFont(name: "Avenir-Book", size: 12)
        firstNameLabel.textAlignment = .center
        contentView.addSubview(firstNameLabel)
        
        lastNameLabel.backgroundColor = UIColor.white
        lastNameLabel.font = UIFont(name: "Avenir-Book", size: 12)
        lastNameLabel.textAlignment = .center
        contentView.addSubview(lastNameLabel)
    }
    
    func setContraints() {
        let labelHeight = frame.height / 5
        let imageViewSide: CGFloat = frame.height / 2
        
        lastNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([lastNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     lastNameLabel.leftAnchor.constraint(equalTo: leftAnchor),
                                     lastNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
                                     lastNameLabel.heightAnchor.constraint(equalToConstant: labelHeight)])
        
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([firstNameLabel.bottomAnchor.constraint(equalTo: lastNameLabel.topAnchor),
                                     firstNameLabel.leftAnchor.constraint(equalTo: leftAnchor),
                                     firstNameLabel.rightAnchor.constraint(equalTo: rightAnchor),
                                     firstNameLabel.heightAnchor.constraint(equalToConstant: labelHeight)])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalToConstant: imageViewSide),
                                     imageView.heightAnchor.constraint(equalToConstant: imageViewSide),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: firstNameLabel.topAnchor, constant: -5.0)])
        
        imageView.layer.cornerRadius = imageViewSide / 2
        imageView.layer.masksToBounds = true
    }
}
