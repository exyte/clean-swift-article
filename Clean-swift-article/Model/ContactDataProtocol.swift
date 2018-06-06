//
//  ContactDataProtocol.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 29/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation

protocol ContactDataProtocol {
    func getContacts() -> [Contact]
    func removeContact(id: String)
    func add(contact: Contact)
    func addOrUpdate(contact: Contact)
}
