//
//  WordScrambleUITests.swift
//  WordScrambleUITests
//
//  Created by Ian Huettel on 1/15/21.
//

import XCTest
var app: XCUIApplication!

class WordScrambleUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }

    func testRules() throws {
        app.buttons["Rules"].tap()
        let rulesAlert = app.staticTexts["Points are earned as follows:"]
        XCTAssertTrue(rulesAlert.exists, "Could not find rules prompt.")
        app.buttons["Continue"].tap()
        XCTAssertTrue(!rulesAlert.exists, "Rules prompt not dismissed.")
    }
    
    func testEnterWord() {
        
        let app = XCUIApplication()
        app.textFields.firstMatch.tap()
        for key in Array("swiftiest") {
            app.keys[String(key)].tap()
        }
        app.buttons["Return"].tap()
        
        XCTAssertTrue(app.buttons["Continue"].exists, #"Somehow, "swiftiest" was accepted."#)
    }
}
