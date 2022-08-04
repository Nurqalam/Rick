//
//  RickUITests.swift
//  RickUITests
//
//  Created by Nurqalam on 04.08.2022.
//

import XCTest

class RickUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
        let collectionViewsQuery = app.collectionViews
        let charsVC = collectionViewsQuery.cells.containing(.staticText,
                                                            identifier: "Characters")
        XCTAssertTrue(charsVC.element.exists)
        charsVC.element.tap()
        collectionViewsQuery.cells.containing(.staticText,
                                              identifier: "Morty Smith").element.tap()
    }
}
