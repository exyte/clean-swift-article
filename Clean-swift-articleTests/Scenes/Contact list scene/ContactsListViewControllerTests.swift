//
//  ContactsListViewControllerTests.swift
//  Clean-swift-articleTests
//
//  Created by Anton Marunko on 04/06/2018.
//  Copyright © 2018 exyte. All rights reserved.
//

import XCTest
@testable import Clean_swift_article

final class ContactsListViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var controller: ContactListViewController!
    var window: UIWindow!
    
    // MARK: - Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupContactListViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        window = nil
    }
    
    // MARK: - Test setup
    
    func setupContactListViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Contact", bundle: bundle)
        controller = storyboard.instantiateViewController(withIdentifier: "contactListControl") as! ContactListViewController
    }
    
    func loadView() {
        window.addSubview(controller.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: - Test doubles
    
    final class ContactListBusinessLogicSpy: ContactListBusinessLogic {
        var contacts: [Contact]?
        
        // MARK: Method call expectations
        
        var fetchContactsCalled = false
        
        // MARK: Spied methods
        
        func showContacts(request: ContactList.ShowContacts.Request) {
            fetchContactsCalled = true
        }
    }
    
    final class TableViewSpy: UITableView
    {
        // MARK: Method call expectations
        
        var reloadDataCalled = false
        
        // MARK: Spied methods
        
        override func reloadData() {
            reloadDataCalled = true
        }
    }
    
    // MARK: - Tests
    
    func testShouldFetchContactsWhenViewDidAppear() {
        // Given
        let contactListBusinessLogicSpy = ContactListBusinessLogicSpy()
        controller.interactor = contactListBusinessLogicSpy
        loadView()
        
        // When
        controller.viewWillAppear(true)
        
        // Then
        XCTAssert(contactListBusinessLogicSpy.fetchContactsCalled, "Should fetch contacts right before the view appears")
    }
    
    func testShouldDisplayFetchedContacts() {
        // Given
        let tableViewSpy = TableViewSpy()
        controller.tableView = tableViewSpy
        
        // When
        let displayedContacts = [ContactList.ShowContacts.ViewModel.DisplayedContact(firstName: "ivan", lastName: "petrov")]
        let viewModel = ContactList.ShowContacts.ViewModel(displayedContacts: displayedContacts)
        controller.displayContacts(viewModel: viewModel)
        
        // Then
        XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched contacts should reload the table view")
    }
    
    func testNumberOfSectionsInTableViewShouldAlwaysBeOne() {
        // Given
        let tableView = controller.tableView
        
        // When
        let numberOfSections = controller.numberOfSections(in: tableView!)
        
        // Then
        XCTAssertEqual(numberOfSections, 1, "The number of table view sections should always be 1")
    }
    
    func testNumberOfRowsInAnySectionShouldEqaulNumberOfOrdersToDisplay() {
        // Given
        let tableView = controller.tableView
        let testDisplayedContacts = [ContactList.ShowContacts.ViewModel.DisplayedContact(firstName: "Ivan", lastName: "Petrov")]
        controller.displayedContacts = testDisplayedContacts
        
        // When
        let numberOfRows = controller.tableView(tableView!, numberOfRowsInSection: 0)
        
        // Then
        XCTAssertEqual(numberOfRows, testDisplayedContacts.count, "The number of table view rows should equal the number of contacts to display")
    }
    
    func testShouldConfigureTableViewCellToDisplayContact() {
        // Given
        let tableView = controller.tableView
        let testDisplayedContacts = [ContactList.ShowContacts.ViewModel.DisplayedContact(firstName: "Ivan", lastName: "Petrov")]
        controller.displayedContacts = testDisplayedContacts
        
        // When
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = controller.tableView(tableView!, cellForRowAt: indexPath)
        
        // Then
        XCTAssertEqual(cell.textLabel?.text, "Ivan Petrov", "A properly configured table view cell should display the contact name")
    }
}
