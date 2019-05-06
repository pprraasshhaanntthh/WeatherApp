//
//  WeatherMobileAppTests.swift
//  WeatherMobileAppTests
//
//  Created by Prashanth on 04/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import XCTest
import Alamofire
@testable import WeatherMobileApp

class WeatherMobileAppTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    
    func test_whenHandlingSampleResponse_withNoErrors_thatForecastObjectReturned() {
        Alamofire.request(CURRENT_WEATHER_URL, method:.get).responseJSON { (response) in
            switch response.result {
            case .failure(_):
                XCTFail()
            case .success(_):
                return
            }
        }
    }

}
