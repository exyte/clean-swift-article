//
//  DBContact.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 29/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation
import RealmSwift

final class DBContact: Object {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""

    @objc dynamic var phone: String = ""
    @objc dynamic var address: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
}
