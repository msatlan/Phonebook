//
//  NavigationCoordinator.swift
//  Phonebook
//
//  Created by MArko Satlan on 10/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

import Foundation
import UIKit


class NavigationCoordinator {
    
// MARK: - Properties
    var navigationController: UINavigationController
    
// MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        showContactsViewController()
    }
    
    private func showDetailsViewController(contact: Contact) {
        let detailsViewController = ContactDetailsViewController()
        detailsViewController.contact = contact
        showViewController(detailsViewController)
    }
    
    private func showContactsViewController() {
        let contactsViewController = ContactsViewController()
        showViewController(contactsViewController)
        contactsViewController.onDidSelectContact = { contact in
            self.showDetailsViewController(contact: contact)
        }
    }
    
    private func showViewController(_ viewController: UIViewController) {
        navigationController.pushViewController(viewController, animated: true)
        /*
        if navigationController.viewControllers.count == 0 {
            navigationController.setViewControllers([viewController], animated: true)
        } else {
            navigationController.pushViewController(viewController, animated: true)
        }*/
    }
}




