//
//  Tests_iOS.swift
//  Tests iOS
//
//  Created by Ian Huettel on 2/16/21.
//

import XCTest
@testable import Moonshot

class Tests_iOS: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBundleDecodeAstronauts() throws {
        let testBundle = Bundle(for: type(of: self)) // Load the test bundle so we can find astronauts.json in shared resources
        let astronauts: [Astronaut] = testBundle.decode("astronauts.json") // Use decode extension on the bundle we found
        XCTAssertEqual(astronauts.count, 32, "Expected 32 astronauts, not \(astronauts.count)") // Make sure the extension worked
    }
    
    func testBundleDecodeMissions() throws {
        let testBundle = Bundle(for: type(of: self))
        let missions: [Mission] = testBundle.decode("missions.json")
        XCTAssertEqual(missions.count, 12, "Expected 12 Apollo missions, not \(missions.count)")
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
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
