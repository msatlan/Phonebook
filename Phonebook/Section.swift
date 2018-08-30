//
//  Section.swift
//  Phonebook
//
//  Created by MArko Satlan on 13/08/2018.
//  Copyright © 2018 MArko Satlan. All rights reserved.
//

class Section {
// MARK: - Properties
    var name: String
    var contactsArray: [Contact] = []
    
// MARK: - Init
    init(name: String) {
        self.name = name
    }
    
// MARK: - Methods
    func addContact(contact: Contact) {
        contactsArray.append(contact)
    }
}
