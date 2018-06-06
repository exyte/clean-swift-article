//
//  Contact.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 25/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation

final class Contact {
    let id: String
    var firstName: String
    var lastName: String

    var phone: String
    var address: String

    init(firstName: String = "",
         lastName: String = "",
         phone: String = "",
         address: String = "",
         id: String = UUID().uuidString) {

        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.phone = phone
        self.address = address
    }
}

extension Contact: RealmConvertable {

    static func mapFromRealmObject(_ object: DBContact) -> Contact {
        let contact = Contact(
            firstName: object.firstName,
            lastName: object.lastName,
            phone: object.phone,
            address: object.address,
            id: object.id)

        return contact
    }

    func mapToRealmObject() -> DBContact {
        let dbContact = DBContact()

        dbContact.id = id
        dbContact.firstName = firstName
        dbContact.lastName = lastName
        dbContact.phone = phone
        dbContact.address = address

        return dbContact
    }
}
