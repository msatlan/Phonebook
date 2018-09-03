//
//  NavigationCoordinator.swift
//  Phonebook
//
//  Created by MArko Satlan on 10/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import UIKit

class NavigationCoordinator {
// MARK: - Properties
    var navigationController: UINavigationController
    
// MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showContactsViewController()
    }
    
// MARK: - Navigation
    private func showViewController(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func showContactsViewController() {
        let contactsViewController = ContactsViewController(viewModel: ContactsViewModel())
        showViewController(contactsViewController)
        contactsViewController.onDidSelectContact = { contact in
            self.showDetailsViewController(contact: contact)
        }
        
        contactsViewController.onDidSelectAddContact = { contactsViewModel in
            self.showNewContactViewController(contactsViewModel: contactsViewModel)
        }
    }
    
    private func showDetailsViewController(contact: Contact) {
        let detailsViewController = ContactDetailsViewController()
        detailsViewController.contact = contact
        self.showViewController(detailsViewController)
    }
    
    private func showNewContactViewController(contactsViewModel: ContactsViewModel) {
        let newContactViewController = NewContactViewController(viewModel: NewContactViewModel())
        let navigationController = UINavigationController(rootViewController: newContactViewController)
        self.navigationController.present(navigationController, animated: true, completion: nil)
        
        newContactViewController.onDidSelectCancel = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        
        newContactViewController.onDidSelectDone = {
            self.navigationController.dismiss(animated: true, completion: nil)
        }
    }
}




