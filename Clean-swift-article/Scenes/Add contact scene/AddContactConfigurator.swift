//
//  AddContactConfigurator.swift
//  Clean-swift-article
//
//  Created by Anton Marunko on 01/06/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import Foundation
import UIKit

final class AddContactConfigurator {
    static let sharedInstance = AddContactConfigurator()

    private init() {}

    func configure(_ control: AddContactViewController) {
        let viewController = control
        let interactor = AddContactInteractor()
        let presenter = AddContactPresenter()
        let router = AddContactRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}
