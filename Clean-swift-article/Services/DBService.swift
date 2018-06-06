//
//  DBService.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 29/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation
import RealmSwift

final class DBService {
    static let shared = DBService()

    private let realm = try! Realm()
    private init() {}
}

extension DBService: ContactDataProtocol {
    func addOrUpdate(contact: Contact) {
        try! realm.write {
            if let object = realm.object(ofType: DBContact.self, forPrimaryKey: contact.id) {
                object.firstName = contact.firstName
                object.lastName = contact.lastName
                object.address = contact.address
                object.phone = contact.phone
            } else {
                realm.add(contact.mapToRealmObject())
            }
        }
    }

    func getContacts() -> [Contact] {
        let contacts = realm.objects(DBContact.self).map { $0 }
        let mapped = Array(contacts.map { Contact.mapFromRealmObject($0) })

        return mapped
    }

    func removeContact(id: String) {
        try! realm.write {
            if let object = realm.object(ofType: DBContact.self, forPrimaryKey: id) {
                realm.delete(object)
            }
        }
    }

    func add(contact: Contact) {
        try! realm.write {
            realm.add(contact.mapToRealmObject())
        }
    }

}
