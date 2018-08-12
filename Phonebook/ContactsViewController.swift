//
//  ViewController.swift
//  Phonebook
//
//  Created by MArko Satlan on 07/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
// MARK: - Properties
    let searchBar = UISearchBar()
    let collectionView = CollectionView()
    var contactsArray: [Contact] = []
    var onDidSelectContact: ((Contact) -> ())?
    
// MARK: - Constants
    let cellIdentifier = "Cell"
    
// MARK : - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        let c1 = Contact()
        c1.firstName = "mirko"
        c1.lastName = "prijatelj od slavka"
        
        let c2 = Contact()
        c2.firstName = "slavko"
        c2.lastName = "prijatelj od mirka"
        
        let c3 = Contact()
        c3.firstName = "betmen"
        c3.lastName = "sismis"
        
        let c4 = Contact()
        c4.firstName = "jovo"
        c4.lastName = "binsr"
        
        contactsArray.append(c1)
        contactsArray.append(c2)
        contactsArray.append(c3)
        contactsArray.append(c4)
        
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        configureUI()
        setConstraints()
    }
    
    func configureUI() {
        collectionView.backgroundColor = UIColor.gray
    
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        view.addSubview(searchBar)
    }
    
    func setConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([searchBar.topAnchor.constraint(equalTo: guide.topAnchor),
                                     searchBar.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                     searchBar.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                     searchBar.heightAnchor.constraint(equalToConstant: 40)])
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
                                     collectionView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)])
    }
    
    @objc func addTapped() {
        print("add")
    }
}

extension ContactsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        let contact = contactsArray[indexPath.row]
        cell.configure(for: contact)
        return cell
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CustomCollectionViewCell.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       onDidSelectContact?(contactsArray[indexPath.row])
    }
}

