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
    var imageView = UIImageView()
    var topLabel = UILabel()
    var bottomLabel = UILabel()

// MARK: - Methods - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        setContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Configure UI / set constraints
    private func configureUI() {
        backgroundColor = UIColor.gray
        layer.cornerRadius = 10
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        imageView.backgroundColor = UIColor.white
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        topLabel.backgroundColor = UIColor.white
        topLabel.font = UIFont(name: "Avenir-Book", size: 12)
        topLabel.textAlignment = .center
        
        contentView.addSubview(topLabel)
        
        bottomLabel.backgroundColor = UIColor.white
        bottomLabel.font = UIFont(name: "Avenir-Book", size: 12)
        bottomLabel.textAlignment = .center

        contentView.addSubview(bottomLabel)
    }
    
    private func setContraints() {
        let labelHeight = frame.height / 5
        let imageViewSide: CGFloat = frame.height / 2
        
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     bottomLabel.leftAnchor.constraint(equalTo: leftAnchor),
                                     bottomLabel.rightAnchor.constraint(equalTo: rightAnchor),
                                     bottomLabel.heightAnchor.constraint(equalToConstant: labelHeight)])
        
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([topLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor),
                                     topLabel.leftAnchor.constraint(equalTo: leftAnchor),
                                     topLabel.rightAnchor.constraint(equalTo: rightAnchor),
                                     topLabel.heightAnchor.constraint(equalToConstant: labelHeight)])
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([imageView.widthAnchor.constraint(equalToConstant: imageViewSide),
                                     imageView.heightAnchor.constraint(equalToConstant: imageViewSide),
                                     imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     imageView.bottomAnchor.constraint(equalTo: topLabel.topAnchor, constant: -5.0)])
        
        imageView.layer.cornerRadius = imageViewSide / 2
        imageView.layer.masksToBounds = true
    }
}
