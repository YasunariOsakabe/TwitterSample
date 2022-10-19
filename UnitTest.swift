//
//  UnitTestTests.swift
//  UnitTestTests
//
//  Created by 小坂部泰成 on 2022/10/18.
//

import XCTest
@testable import UnitTest

class UnitTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
        
        func trueTextLimit() {
            let vc = ViewController()
            let number = vc.saveRecord(with: 120)
            XCTAssertTrue(number)
        }
        
        func falseTextLimit() {
            let vc = ViewController()
            let number = vc.saveRecord(with: 160)
            XCTAssertFalse(number)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

