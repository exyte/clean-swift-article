//
//  RealmConvertable.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 29/05/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation
import RealmSwift

protocol RealmConvertable {

    associatedtype RealmType: Object

    func mapToRealmObject() -> RealmType
    static func mapFromRealmObject(_ object: RealmType) -> Self
}
