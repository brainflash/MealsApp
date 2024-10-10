//
//  SearchForMealUseCaseTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import XCTest
import PromiseKit
@testable import MealsApp

class SearchForMealUseCaseTests: XCTestCase {

	var useCase: SearchForMealUseCaseImpl!
	var repository: MockMealsRepository!

	override func setUp() {
		super.setUp()

		// Initialize mocks
		repository = MockMealsRepository()

		// Initialize SUT
		useCase = SearchForMealUseCaseImpl(repository: repository)
	}

	override func tearDown() {
		useCase = nil
		repository = nil
		super.tearDown()
	}

	func testExecuteSuccess() {
		// Given
		let query = "Pasta"
		let expectedMeals = [
			Meal(id: "1", name: "Lasagna Sandwiches"),
			Meal(id: "2", name: "Fettuccine Alfredo")
		]
		repository.mockMeals = expectedMeals
		
		let expectation = self.expectation(description: "Successfully searched for meals")
		
		// When
		useCase.execute(query: query).done { meals in
			// Then
			XCTAssertEqual(meals, expectedMeals)
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testExecuteFailure() {
		// Given
		let query = "Pasta"
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		repository.mockError = expectedError
		
		let expectation = self.expectation(description: "Searching for meals failed")

		// When
		useCase.execute(query: query).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
}
