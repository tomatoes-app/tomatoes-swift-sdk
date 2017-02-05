//
//  TomatoesTests.swift
//  tomatoes-swift-sdk
//
//  Created by Giorgia Marenda on 2/5/17.
//
//

import XCTest
import OHHTTPStubs
@testable import Tomatoes

class TomatoesTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        OHHTTPStubs.removeAllStubs()
    }
    
    func stubEndpoint(endpoint: Tomatoes) {
        stub(condition: isPath(endpoint.path)) { _ in
            guard let stubPath = OHPathForFile(endpoint.stubFileName, type(of: self)) else {
                assertionFailure("Stub file \(endpoint.stubFileName) not founded")
                return OHHTTPStubsResponse()
            }
            return fixture(filePath: stubPath, headers: ["Content-Type":"application/json"])
        }
    }
    
    func testSession() {
        stubEndpoint(endpoint: Tomatoes.createSession)
        let expect = expectation(description: "Session post")
        let session = Session(provider: .github, accessToken: "fakefake")
        session.create { (result) in
            switch result {
            case .success(let token):
                XCTAssertEqual(token, "d994a295cf68342b99e3036827d3ef8a")
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadUser() {
        stubEndpoint(endpoint: Tomatoes.readUser)
        let expect = expectation(description: "User get")
        User.read { result in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.name, "Giovanni Cappellotto")
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadTomaotes() {
        stubEndpoint(endpoint: Tomatoes.readTomatoes(page: 1))
        let expect = expectation(description: "Tomatoes get")
        Tomato.items(page: 1) { (result) in
            switch result {
            case .success(let tomatoes):
                XCTAssertEqual(tomatoes.items?.count, 2)
                XCTAssertEqual(tomatoes.items?.first?.id, "57f9c9377c8402dd306d1c8b")
                XCTAssertEqual(tomatoes.currentPage, 1)
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadTomaote() {
        stubEndpoint(endpoint: Tomatoes.readTomato(id: "1"))
        let expect = expectation(description: "Tomato get")
        Tomato.read(id: "1") { (result) in
            switch result {
            case .success(let tomato):
                XCTAssertEqual(tomato.id, "1")
                XCTAssertEqual(tomato.tags!,  ["one", "two"])
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadProjects() {
        stubEndpoint(endpoint: Tomatoes.readProjects(page: 1))
        let expect = expectation(description: "Projects get")
        Project.items(page: 1) { (result) in
            switch result {
            case .success(let projects):
                XCTAssertEqual(projects.items?.count, 1)
                XCTAssertEqual(projects.items?.first?.id, "57f9c9377c8402dd306d1c8b")
                XCTAssertEqual(projects.items?.first?.name, "Web app")
                XCTAssertEqual(projects.currentPage, 1)
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testReadProject() {
        stubEndpoint(endpoint: Tomatoes.readProject(id: "1"))
        let expect = expectation(description: "Project get")
        Project.read(id: "1") { (result) in
            switch result {
            case .success(let project):
                XCTAssertEqual(project.id, "1")
                XCTAssertEqual(project.tags!,  ["ruby", "acme"])
                XCTAssertEqual(project.moneyBudget, 1200)
                XCTAssertEqual(project.timeBudget, 120)
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testReadLeaderboard() {
        stubEndpoint(endpoint: Tomatoes.readLeaderboard(period: .weekly, page: 1))
        let expect = expectation(description: "Leaderboard get")
        Score.items(period: .weekly, page: 1) { (result) in
            switch result {
            case .success(let score):
                XCTAssertEqual(score.items?.first?.user?.name, "Giovanni Cappellotto")
            case .failure: XCTFail()
            }
            expect.fulfill()
        }
        waitForExpectations(timeout: 2, handler: nil)
    }
}
