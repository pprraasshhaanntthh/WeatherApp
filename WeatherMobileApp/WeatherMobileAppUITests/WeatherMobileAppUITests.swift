//
//  WeatherMobileAppUITests.swift
//  WeatherMobileAppUITests
//
//  Created by Prashanth on 04/05/19.
//  Copyright © 2019 Prashanth. All rights reserved.
//

import XCTest

class WeatherMobileAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let refreshButton = app.navigationBars["Kukatpalli"].buttons["Refresh"]
        refreshButton.tap()
        
        let tabBarsQuery = app.tabBars
        let hourlyButton = tabBarsQuery.buttons["Hourly"]
        hourlyButton.tap()
        tabBarsQuery.buttons["Days"].tap()
        refreshButton.tap()
        hourlyButton.tap()
        refreshButton.tap()
        tabBarsQuery.buttons["Now"].tap()
        
    }

}
