//
//  iExpenseUITests.swift
//  iExpenseUITests
//
//  Created by Ian Huettel on 1/24/21.
//

import XCTest
@testable import iExpense

let app = XCUIApplication()

class iExpenseUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        // Add a check to make sure Toggle Software Keyboard is enabled in the sim
        // If not, this will fail tests that rely on keyboard taps.
    }

    override func tearDownWithError() throws {
        app.terminate()
    }

    func testOpenAddExpenseMenu() throws {
        let addItemButton = app.buttons["plus"]
        addItemButton.tap()
        XCTAssertTrue(app.staticTexts["Add Expense"].exists, "Add Expense view was not found after tapping plus.")
    }
    
 // Test the Add Expense view for interactibility.
    func testAddExpenseFieldsEditable() throws {
        app.buttons["plus"].tap()
        app.textFields["Expense"].tap()
        
        for char in "Business" {
            app.keys[String(char)].tap()
        }
        app.keys["space"].tap()
        app.buttons["shift"].tap()
        for char in "Lunch" {
            app.keys[String(char)].tap()
        }
        
        app.textFields["$0.00"].tap()
        
        for char in "25.95" {
            app.keys[String(char)].tap()
        }
        
        app.buttons["Type of Expense"].tap()
        app.buttons["Business"].tap()
        
        app.buttons["Save"].tap()
        
        XCTAssertTrue(app.staticTexts["Business Lunch"].exists, #""Business Lunch" was not entered successfully."#)
        XCTAssertTrue(app.staticTexts["$25.95"].exists, #""$25.95" was not entered successfully."#)
    }
    
 // Test that Expense is autopopulated with "Expense" if nothing is entered
    func testDefaultExpenseValue() throws {
        app.buttons["plus"].tap()
        app.textFields["$0.00"].tap()
        
        for char in "1" {
            app.keys[String(char)].tap()
        }
        
        app.buttons["Save"].tap()
        
        XCTAssertTrue(app.staticTexts["Expense"].exists, #"A defaul value of "Expense" wasn't made."#)
    }
    
 // Test that the user can delete an expense via Edit
 // This test is flakey and bad because it relies on a previous test
 // I haven't learned much about mocking yet, however that would
 // be a perfect solution and make these tests not co-dependant.
    func testDeleteExpenseByTap() throws {
        app.buttons["Edit"].tap()
        XCTAssertTrue(app.buttons["Done"].isHittable, "Edit not tapped or Done did not appear.")
        app.staticTexts["Business Lunch"].tap()
        app.cells["Business Lunch, $25.95, Business"].buttons["Delete "].tap()
        app.buttons["Delete"].tap()
 // This is also a reason we need mocking.
 // Weirdly enough, this test is also failing in the sim,
 // because the "Delete " button does not appear.
 // I don't think this is an intended feature.
 // As such, I've disabled it until I've figured this out.
        XCTAssertFalse(app.buttons["Business Lunch"].exists, "Business lunch still exists, or a duplicate existed prior to deleting.")
    }
    
 // Test that the user can delete by swiping the row away
 // This test is flakey and bad because it relies on a previous test
 // I haven't learned much about mocking yet, however that would
 // be a perfect solution and make these tests not co-dependant.
    func testDeleteExpenseBySwipe() throws {
        app.staticTexts["Expense"].swipeLeft()
        app.buttons["Delete"].tap()
 // This is also a reason we need mocking.
        XCTAssertFalse(app.buttons["Expense"].exists, "Expense still exists, or a duplicate existed prior to deleting.")
    }
}
