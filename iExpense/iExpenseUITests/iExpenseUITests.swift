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
    
    func testEx2() throws {
        
        let app = XCUIApplication()
        app.navigationBars["iExpense"].buttons["plus"].tap()
        app.tables/*@START_MENU_TOKEN@*/.textFields["Expense"]/*[[".cells[\"Expense\"].textFields[\"Expense\"]",".textFields[\"Expense\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let sKey = app/*@START_MENU_TOKEN@*/.keys["S"]/*[[".keyboards.keys[\"S\"]",".keys[\"S\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        sKey.tap()
        sKey.tap()
        app/*@START_MENU_TOKEN@*/.buttons["shift"]/*[[".keyboards.buttons[\"shift\"]",".buttons[\"shift\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["H"]/*[[".keyboards.keys[\"H\"]",".keys[\"H\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        
        let app = XCUIApplication()
        let iexpenseNavigationBar = app.navigationBars["iExpense"]
        let editButton = iexpenseNavigationBar.buttons["Edit"]
        editButton.tap()
        
        let doneButton = iexpenseNavigationBar.buttons["Done"]
        doneButton.tap()
        editButton.tap()
        
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Business"]/*[[".cells[\"Stuff, $200.00, Business\"].staticTexts[\"Business\"]",".staticTexts[\"Business\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeLeft()
        
        let stuff20000BusinessCell = tablesQuery.cells["Stuff, $200.00, Business"]
        stuff20000BusinessCell.children(matching: .other).element(boundBy: 2).children(matching: .other).element.swipeRight()
        stuff20000BusinessCell.children(matching: .other).element(boundBy: 0).tap()
        editButton.tap()
        stuff20000BusinessCell.buttons["Delete "].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Delete"]/*[[".cells[\"Stuff, $200.00, Business\"].buttons[\"Delete\"]",".buttons[\"Delete\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        doneButton.tap()
        
        let plusButton = app.navigationBars["iExpense"].buttons["plus"]
        plusButton.tap()
        
        let addExpenseNavigationBar = app.navigationBars["Add Expense"]
        addExpenseNavigationBar.staticTexts["Add Expense"].swipeDown()
        plusButton.tap()
        
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["Expense"]/*[[".cells[\"Expense\"].textFields[\"Expense\"]",".textFields[\"Expense\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let textField = tablesQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells[\"$0.00\"].textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        textField.tap()
        textField.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.buttons["Type of Expense"]/*[[".cells[\"Type of Expense\"].buttons[\"Type of Expense\"]",".buttons[\"Type of Expense\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 0).tap()
        tablesQuery/*@START_MENU_TOKEN@*/.textFields["$0.00"]/*[[".cells.textFields[\"$0.00\"]",".textFields[\"$0.00\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let saveButton = addExpenseNavigationBar.buttons["Save"]
        saveButton.tap()
        app.alerts["Error"].scrollViews.otherElements.buttons["Dismiss"].tap()
        saveButton.tap()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
}
