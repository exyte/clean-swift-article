//
//  ContactListPresenterTests.swift
//  Clean-swift-articleTests
//
//  Created by Anton Marunko on 04/06/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

@testable import Clean_swift_article
import XCTest

final class ListOrdersPresenterTests: XCTestCase {
    // MARK: - Subject under test
    
    var presenter: ContactListPresenter!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupContactListPresenter()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupContactListPresenter() {
        presenter = ContactListPresenter()
    }
    
    // MARK: - Test doubles
    
    final class ContactListDisplayLogicSpy: ContactListDisplayLogic {
        
        
        // MARK: Method call expectations
        
        var displayFetchedContactsCalled = false
        
        // MARK: Argument expectations
        
        var viewModel: ContactList.ShowContacts.ViewModel!
        
        // MARK: Spied methods
        
        func displayContacts(viewModel: ContactList.ShowContacts.ViewModel) {
            displayFetchedContactsCalled = true
            self.viewModel = viewModel
        }
    }
    
    // MARK: - Tests
    
    func testPresentFetchedContactsShouldFormatFetchedContactsForDisplay() {
        // Given
        let contactListDisplayLogicSpy = ContactListDisplayLogicSpy()
        presenter.viewController = contactListDisplayLogicSpy
        
        // When
        
        let ivan = TestData.Contacts.ivan
        let contacts = [ivan]
        
        let response = ContactList.ShowContacts.Response(contacts: contacts)
        presenter.presentContacts(response: response)
        
        // Then
        let displayedContacts = contactListDisplayLogicSpy.viewModel.displayedContacts
        for displayedContact in displayedContacts {
            XCTAssertEqual(displayedContact.fullName, "Ivan Petrov", "Presenting fetched contacts should properly format name")
        }
    }
    
    func testPresentFetchedOrdersShouldAskViewControllerToDisplayFetchedOrders() {
        // Given
        let contactsLostDisplayLogicSpy = ContactListDisplayLogicSpy()
        presenter.viewController = contactsLostDisplayLogicSpy
        
        // When
        let contacts = [TestData.Contacts.ivan]
        let response = ContactList.ShowContacts.Response(contacts: contacts)
        presenter.presentContacts(response: response)
        
        // Then
        XCTAssert(contactsLostDisplayLogicSpy.displayFetchedContactsCalled, "Presenting fetched contacts should ask view controller to display them")
    }
}
