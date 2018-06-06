//
//  ContactListInteractorTest.swift
//  Clean-swift-articleTests
//
//  Created by Anton Marunko on 01/06/2018.
//  Copyright © 2018 exyte. All rights reserved.
//
@testable import Clean_swift_article
import XCTest

final class ContactListInteractorTests: XCTestCase {
    
    var interactor: ContactListInteractor!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupIntercator()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Test setup
    
    func setupIntercator() {
        interactor = ContactListInteractor()
    }
    
    final class ContactListPresentationLogicSpy: ContactListPresentationLogic {
        
        // MARK: Method call expectations
        
        var presentFetchedContactsCalled = false
        
        // MARK: Spied methods
        
        func presentContacts(response: ContactList.ShowContacts.Response) {
            presentFetchedContactsCalled = true
        }
    }
    
    final class ContactsListWorkerSpy: ContactListWorker {
        // MARK: Method call expectations
        
        var fetchContactsCalled = false
        
        // MARK: Spied methods
        
        override func getContacts() -> [Contact] {
            fetchContactsCalled = true
            return [Contact]()
        }
    }
    
    func testFetchContactsShouldAskContactsWorkerToFetchContactsAndPresenterToFormatResult() {
        // Given
        let contactsListPresentationLogicSpy = ContactListPresentationLogicSpy()
        interactor.presenter = contactsListPresentationLogicSpy
        let contactsListWorkerSpy = ContactsListWorkerSpy()
        interactor.worker = contactsListWorkerSpy
        
        // When
        let request = ContactList.ShowContacts.Request()
        interactor.showContacts(request: request)
        
        // Then
        XCTAssert(contactsListWorkerSpy.fetchContactsCalled, "FetchOrders() should ask OrdersWorker to fetch orders")
        XCTAssert(contactsListPresentationLogicSpy.presentFetchedContactsCalled, "FetchOrders() should ask presenter to format orders result")
    }
}
