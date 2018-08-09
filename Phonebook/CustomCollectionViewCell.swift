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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Layout subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let verticalMargin: CGFloat = frame.height / 10
        
        let imageViewWidth: CGFloat = frame.width / 2
        let imageViewHeight: CGFloat = frame.width / 2
        
        imageView.frame = CGRect(x: (frame.width - imageViewWidth) / 2,
                                 y: verticalMargin,
                                 width: imageViewWidth,
                                 height: imageViewHeight)
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        
        firstNameLabel.frame = CGRect(x: 0,
                                      y: imageViewHeight + 2 * verticalMargin,
                                      width: frame.width,
                                      height: (frame.height - (imageViewHeight + 2 * verticalMargin)) / 2)
        
        lastNameLabel.frame = CGRect(x: 0,
                                     y: firstNameLabel.frame.origin.y + firstNameLabel.frame.height,
                                     width: frame.width,
                                     height: (frame.height - (imageViewHeight + 2 * verticalMargin)) / 2)
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
}
