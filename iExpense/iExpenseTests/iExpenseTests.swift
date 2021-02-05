//
//  iExpenseTests.swift
//  iExpenseTests
//
//  Created by Ian Huettel on 1/24/21.
//

import XCTest
@testable import iExpense

class iExpenseTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPersonalExpense() throws {
        let item = ExpenseItem(name: "food", cost: 1000.00)
        XCTAssertTrue(item.name == "food")
        XCTAssertTrue(item.cost == 1000.00)
        XCTAssertTrue(item.isForBusiness == false)
    }
    
    func testBusinessExpense() throws {
        let item = ExpenseItem(name: "plane ticket", cost: 450.99, isForBusiness: true)
        XCTAssertTrue(item.name == "plane ticket")
        XCTAssertTrue(item.cost == 450.99)
        XCTAssertTrue(item.isForBusiness == true)
    }
    
    func testMultipleExpenses() throws {
        let expenses = Expenses()
        for cost in 1 ... 3 {
            let newItem = ExpenseItem(name: "Stuff", cost: Double(cost * 100), isForBusiness: cost % 2 == 0 ? true : false)
            expenses.items.append(newItem)
        }
        XCTAssertTrue(expenses.items.count == 3)
        XCTAssertTrue(expenses.items.first(where: {$0.isForBusiness == true} )?.cost == Double(200))
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
