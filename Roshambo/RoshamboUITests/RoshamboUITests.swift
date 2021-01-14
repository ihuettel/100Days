//
//  RoshamboUITests.swift
//  RoshamboUITests
//
//  Created by ihuettel on 1/13/21.
//

import XCTest

class RoshamboUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAllMoves() throws {
        let app = XCUIApplication()
        app.launch()

        for move in ["Rock", "Paper", "Scissors"] {
            app.buttons[move].tap()
            app.alerts.buttons["Continue"].tap()
        }
    }
    
    func testPerfectGame() throws {
        let app = XCUIApplication()
        app.launch()
        
        for _ in 0 ..< 10 {
            let shouldWinText = app.staticTexts["shouldWin"].label
            let opponentsMove = app.staticTexts["opponentsMove"].label
            
            var correctMove: String {
                if shouldWinText == "You must win." {
                    switch opponentsMove {
                    case "Rock":
                        return "Paper"
                    case "Paper":
                        return "Scissors"
                    case "Scissors":
                        return "Rock"
                    default:
                        return "Dynamite"
                    }
                } else {
                    switch opponentsMove {
                    case "Rock":
                        return "Scissors"
                    case "Paper":
                        return "Rock"
                    case "Scissors":
                        return "Paper"
                    default:
                        return "Dynamite"
                    }
                }
            }
            
            XCTAssertNotEqual(opponentsMove, "Dynamite", "Your opponent wound up with Dynamite, somehow.")
            XCTAssertNotEqual(correctMove, "Dynamite", "You wound up with Dynamite, somehow.")
            
            app.buttons[correctMove].tap()
            
            let alert: XCUIElement = app.alerts["Correct!"]
            XCTAssertTrue(alert.exists, "Wrong answer in an otherwise perfect game.")
            app.alerts.buttons["Continue"].tap()
        }
        //let scoreText = app.staticTexts["scoreText"].label
        //XCTAssertEqual(scoreText, "Correct Answers: 10 | Total Answers: 10", "Didn't end 10/10.")
        //
        //  This code won't work until I implement a "Restart Game" button instead of automatically resetting it
        //  I could also change the way the game functions to make it work, but that's not what I want.
        //  I hope to revisit this at some point, but this was my first foray into testing, and I feel
        //  that I've learned quite a bit already. #staticTextNotTextView
        //
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
