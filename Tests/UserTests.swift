//
//  UserTests.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 2/4/17.
//
//

import XCTest
import OHHTTPStubs
@testable import Tomatoes

class UserTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func stubEndpoint(endpoint: Tomatoes) {
        stub(condition: isPath(endpoint.path)) { _ in
            guard let stubPath = OHPathForFile(endpoint.stubFileName, type(of: self)) else {
                assertionFailure("Stub file \(endpoint.stubFileName).json not founded")
                return OHHTTPStubsResponse()
            }
            return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
        }
    }
    
    func testReadUser() {
        stubEndpoint(endpoint: Tomatoes.readUser)
        let expect = expectation(description: "User get")
        User.read { (result, error) in
            XCTAssertNil(error)
            if let user = result as? User {
                XCTAssertEqual(user.name, "Giovanni Cappellotto")
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadTomaotes() {
        stubEndpoint(endpoint: Tomatoes.readTomatoes(page: 1))
        let expect = expectation(description: "Tomatoes get")
        Tomato.items(page: 1) { (result, error) in
            if let tomatoes = result as? PaginatedList<Tomato> {
                XCTAssertEqual(tomatoes.items?.count, 2)
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
