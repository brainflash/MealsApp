//
//  MealsAppUITests.swift
//  MealsAppUITests
//
//  Created by Chris Scutt on 07/10/2024.
//

import XCTest

final class MealsAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
		
		// TODO: these UI tests need mock data, currently they require a network connection to pass
    }

    override func tearDownWithError() throws {
    }
	
	@MainActor
	func testSearchForMeal() throws {
		let app = XCUIApplication()
		app.launch()
		
		let searchBox = app.searchFields["Search for a meal"]
		XCTAssertTrue(searchBox.exists)

		searchBox.tap()
		
		searchBox.typeText("Pizza")
		
		let exists = NSPredicate(format: "exists == 1")
		let pizzaMeal = app.images["Pizza Express Margherita image"]
		expectation(for: exists, evaluatedWith: pizzaMeal, handler: nil)
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(pizzaMeal.exists)
	}
	
	@MainActor
	func testRandomMealButton() throws {
		let app = XCUIApplication()
		app.launch()
		
		let randomButton = app.buttons["Random meal"]
		XCTAssertTrue(randomButton.exists)
		
		randomButton.tap()
		
		let mealImage = app.images["Meal image"]
		XCTAssertTrue(mealImage.exists)
	}

	@MainActor
	func testCategoryViewSwiping() throws {
		let app = XCUIApplication()
		app.launch()

		for _ in 0...1 {
			app.swipeUp()
		}
		
		let categoryImage = app.images["Seafood category image"]
		XCTAssertTrue(categoryImage.exists)
	}
	
	@MainActor
	func testCategorySelection() throws {
		let app = XCUIApplication()
		app.launch()

		app.swipeUp()

		let exists = NSPredicate(format: "exists == 1")
		let categoryImage = app.images["Seafood category image"]
		expectation(for: exists, evaluatedWith: categoryImage, handler: nil)
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(categoryImage.exists)
		
		categoryImage.tap()
		
		let fishFofos = app.images["Fish fofos image"]
		expectation(for: exists, evaluatedWith: fishFofos, handler: nil)
		waitForExpectations(timeout: 5, handler: nil)
		XCTAssertTrue(fishFofos.exists)
	}
	
	@MainActor
	func testMealSelection() throws {
		let app = XCUIApplication()
		app.launch()

		app.swipeUp()
		
		let seafood = app.images["Seafood category image"]
		XCTAssertTrue(seafood.exists)
		seafood.tap()
		
		let fishFofos = app.images["Fish fofos image"]
		XCTAssertTrue(fishFofos.exists)
		
		fishFofos.tap()
		let youTubeButton = app.buttons["YouTube video"]
		XCTAssertTrue(youTubeButton.exists)
	}
	
	@MainActor
	func testIngredientsView() throws {
		let app = XCUIApplication()
		app.launch()

		app.swipeUp()
		
		let categoryImage = app.images["Seafood category image"]
		XCTAssertTrue(categoryImage.exists)
		
		categoryImage.tap()
		
		let mealImage = app.images["Fish fofos image"]
		XCTAssertTrue(mealImage.exists)
		
		mealImage.tap()
		
		let ingredientsButton = app.buttons["Ingredients"]
		XCTAssertTrue(ingredientsButton.exists)
		
		ingredientsButton.tap()
		
		let ingredientText = app.staticTexts["Haddock"]
		XCTAssertTrue(ingredientText.exists)
	}
}
