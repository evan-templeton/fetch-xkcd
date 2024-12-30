//
//  fetch_xkcdUITests.swift
//  fetch-xkcdUITests
//
//  Created by Evan Templeton on 12/28/24.
//

import XCTest

final class fetch_xkcdUITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    func testSearchInputInitialValue() {
        let searchField = app.textFields["searchInputField"]
        XCTAssertTrue(searchField.exists, "Search input field should exist.")
        XCTAssertEqual(searchField.value as! String, "1")
    }
    
    func testSearchInputUpperPlaceholder() {
        testSearchInputInitialValue()
        let placeholder = app.staticTexts["searchInputUpperPlaceholder"]
        XCTAssertTrue(placeholder.exists, "Search input upper placeholder should exist when value exists.")
        XCTAssertEqual(placeholder.label, "Enter a number")
    }
    
    func testSearchInputMainPlaceholder() {
        let searchField = app.textFields["searchInputField"]
        XCTAssertTrue(searchField.exists, "Search input field should exist.")
        XCTAssertEqual(searchField.value as! String, "1")
        searchField.tap()
        searchField.typeText(XCUIKeyboardKey.delete.rawValue)
        let placeholder = app.staticTexts["searchInputMainPlaceholder"]
        XCTAssertTrue(placeholder.exists, "Search input main placeholder should exist.")
        XCTAssertEqual(placeholder.label, "Enter a number")
    }
    
    func testSearchInputErrorMessage() {
        testSearchInputMainPlaceholder()
        let errorMessage = app.staticTexts["Please enter a number between 1 and 2843."]
        XCTAssertTrue(errorMessage.exists)
    }
    
    func testGetComicButton() {
        let button = app.buttons["Get Comic"]
        XCTAssertTrue(button.exists, "Get Comic button should exist.")
        XCTAssertTrue(button.isHittable, "Get Comic button should be hittable.")
    }
}
