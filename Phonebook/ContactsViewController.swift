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
    
    var onDidSelectContact: ((Contact) -> ())?
    var onDidSelectAddContact: ((ContactsViewModel) ->())?
    
    let viewModel: ContactsViewModel
    
// MARK: - Constants
    let cellIdentifier = "Cell"
    let headerViewIdentifier = "Header View"

// MARK: - Init
    init(viewModel: ContactsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK : - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
     
        navigationItem.title = "Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        
        configureUI()
        setConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear: \(viewModel.contactsArray.count)")
        viewModel.makeSections()
        collectionView.reloadData()
    }
    
// MARK: - Configure UI / set constraints
    func configureUI() {
        collectionView.backgroundColor = UIColor.lightGray
    
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(CollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerViewIdentifier)
        
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
    
// MARK: - Action methods
    @objc func addTapped() {
        onDidSelectAddContact?(viewModel)
    }
}

extension ContactsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sectionsArray.count
    }
 
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.sectionsArray[section].contactsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        let contact = viewModel.contact(at: indexPath)
        
        cell.topLabel.text = contact.firstName
        cell.bottomLabel.text = contact.lastName
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerViewIdentifier, for: indexPath) as! CollectionReusableView
            
            let sectionName = viewModel.sectionNames[indexPath.section].uppercased()
            
            headerView.label.text = sectionName
            
            return headerView
        default:
            assert(false, "Unexpected element of kind")
        }
    }
}

extension ContactsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CustomCollectionViewCell.cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       onDidSelectContact?(viewModel.contact(at: indexPath))
    }
}

