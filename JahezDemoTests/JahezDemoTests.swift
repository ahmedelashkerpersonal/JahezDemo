//
//  JahezDemoTests.swift
//  JahezDemoTests
//
//  Created by Ahmed Elashker on 16/01/2023.
//

import XCTest
@testable import JahezDemo

final class JahezDemoTests: XCTestCase {

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
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testRestaurantsResponse() async throws {
        
        let restaurants = try await NetworkManager().loadRestaurants()
        XCTAssert(restaurants.isEmpty == false)
    }
    
    func testKudoImageExists() async throws {
        
        let kudoImage = try await NetworkManager().loadImage(urlString: "https://jahez-other-oniiphi8.s3.eu-central-1.amazonaws.com/1.jpg")
        XCTAssertNotNil(kudoImage)
    }
    
    func testOffers() async throws {
        
        let restaurants = try await NetworkManager().loadRestaurants()
        let restaurantsWithOffers = restaurants.filter({$0.hasOffer == true})
        XCTAssertGreaterThan(restaurantsWithOffers.count, 0)
    }
}
