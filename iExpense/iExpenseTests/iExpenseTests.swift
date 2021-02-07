//
//  iExpenseTests.swift
//  iExpenseTests
//
//  Created by Ian Huettel on 1/24/21.
//
//  This was my first successful attempt at writing unit tests in a pseudo TDD style.
//  I liked it and I think it was useful, but I haven't gotten as much the hang of
//  exactly how to do that with UI tests as well. I suppose it may be much the same,
//  but my goal was to actually finish a larger chunk of the project today.
//  I realize on the surface TDD feels slower but it has a lot of good trade-offs.
//
//  I'm just going to need to keep doing it, and keep being better!
//

import XCTest
@testable import iExpense

class iExpenseTests: XCTestCase {

    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonalExpense() throws {
        let item = ExpenseItem(name: "food", cost: 1000.00, type: "Personal")
        XCTAssertTrue(item.name == "food")
        XCTAssertTrue(item.cost == 1000.00)
        XCTAssertTrue(item.type == "Personal")
    }
    
    func testBusinessExpense() throws {
        let item = ExpenseItem(name: "plane ticket", cost: 450.99, type: "Business")
        XCTAssertTrue(item.name == "plane ticket")
        XCTAssertTrue(item.cost == 450.99)
        XCTAssertTrue(item.type == "Business")
    }
    
/*
 // This test is broken by saving user data. I'm sure I can rewrite it, or replace it with something more useful.
 // I might be able to use a stub here and load it with blank user data and then load actual user data.
 // That would be good as I didn't write tests for loading via JSONEncoder.
     
    func testMultipleExpenses() throws {
        let expenses = Expenses()
        for cost in 1 ... 3 {
            let newItem = ExpenseItem(name: "Stuff", cost: Double(cost * 100), type: cost % 2 == 0 ? "Business" : "Personal")
            expenses.items.append(newItem)
        }
        XCTAssertTrue(expenses.items.count == 3)
        XCTAssertTrue(expenses.items.first(where: {$0.type == "Business"} )?.cost == Double(200))
    }
*/
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
