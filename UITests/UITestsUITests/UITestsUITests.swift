//
//  UITestsUITests.swift
//  UITestsUITests
//
//  Created by amin nazemzadeh on 8/4/25.
//

import XCTest

final class UITestsUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    @MainActor
    func testButtonsShowAlerts() {
        let app = XCUIApplication()
        app.buttons["Blue"].tap()
        XCTAssertTrue(app.alerts["Blue"].exists)
        app.alerts["Blue"].buttons["OK"].tap()
    }

    @MainActor
    func testSliderControlsProgress() {
        let app = XCUIApplication()
        app.launch()

        app.sliders["Completion"].adjust(toNormalizedSliderPosition: 1)

        print(app.progressIndicators.count)
        guard let completion = app.progressIndicators["Inverse"].value as? String else {
            XCTFail("Unable to find the progress indicator.")
            return
        }

        XCTAssertEqual(completion, "0%")
    }

    @MainActor
    func testLabelCopiesTextField() {
        let app = XCUIApplication()
        app.launch()
        app.textFields.element.tap()
        app.textFields.element.typeText("Test")
        app.keyboards.buttons["Return"].tap()

        XCTAssertEqual(app.staticTexts["TextCopy"].label, "Test")
    }

    @MainActor
    func testExample() {
        let app = XCUIApplication()
        app.launch()
        app.activate()

        app.textFields.element.tap()
        app.textFields.element.typeText("Test")
        app.keyboards.buttons["Return"].tap()

        app.sliders["Completion"].swipeRight()
        app.segmentedControls.buttons["Omega"].tap()
        app.buttons["Blue"].tap()
        app.alerts["Blue"].buttons["OK"].tap()
    }

    @MainActor
    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
}
