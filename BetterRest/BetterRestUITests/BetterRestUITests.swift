//
//  BetterRestUITests.swift
//  BetterRestUITests
//
//  Created by Ian Huettel on 1/14/21.
//

import XCTest

class BetterRestUITests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testHoursIncrement() throws {
        let incrementButton = app.otherElements["hours"].coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))
        for _ in 0 ... 10 {
            incrementButton.doubleTap()
        }
        XCTAssertEqual(app.staticTexts["hours"].label, "12 hours", "Error incrementing Hours stepper up to 12.")
    }

    func testHoursDecrement() throws {
        let decrementButton = app.otherElements["hours"].coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
        for _ in 0 ... 10 {
            decrementButton.doubleTap()
        }
        XCTAssertEqual(app.staticTexts["hours"].label, "4 hours", "Error decrementing Hours stepper down to 4.")
    }
    
    func testCoffeeIncrement() throws {
        let incrementButton = app.otherElements["coffee"].coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5))
        for _ in 0 ... 10 {
            incrementButton.doubleTap()
        }
        XCTAssertEqual(app.staticTexts["20 cups of coffee"].label, "20 cups of coffee", "Error incrementing Coffee stepper up to 20.")
    }

    func testCoffeeDecrement() throws {
        let decrementButton = app.otherElements["coffee"].coordinate(withNormalizedOffset: CGVector(dx: 0.1, dy: 0.5))
        for _ in 0 ... 10 {
            decrementButton.doubleTap()
        }
        XCTAssertEqual(app.staticTexts["0 cups of coffee"].label, "0 cups of coffee", "Error decrementing Coffee stepper down to 0.")
    }
    
    //
    //  Both testCoffee[...] tests above used to use app.staticTexts["coffee"] until the identifier broke while messing with the UI.
    //  I've toyed around with it, but at the exact thing works above and they're within the same Form/VStack structure, I'm unsure
    //  what could be causing it.
    //
    //  For now, I'm leaving it as is. These tests are to help me learn more about testing, and clearly something here is flaky.
    //  ..it's probably that I'm doing UI testing and know very little, therefore I write flaky UI tests..
    //  I'm honestly surprised how well the coordinate workaround functions. Shoutout to Rob Sturgeon for his article on Medium.
    //  [https://medium.com/twinkl-educational-publishers/accessible-swiftui-for-easy-ui-testing-f2e7b8824b39]
    //  Really helped me fix a lot of basic little things in my UI Tests that weren't working or were inefficient.
    //

}
