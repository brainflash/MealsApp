//
//  FetchMealByIdUseCaseTest.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import XCTest
import PromiseKit
@testable import MealsApp

class FetchMealByIdUseCaseTests: XCTestCase {

	var useCase: FetchMealByIdUseCaseImpl!
	var repository: MockMealsRepository!

	override func setUp() {
		super.setUp()

		repository = MockMealsRepository()
		useCase = FetchMealByIdUseCaseImpl(repository: repository)
	}

	override func tearDown() {
		useCase = nil
		repository = nil
		super.tearDown()
	}

	func testExecuteSuccess() {
		// Given
		let mealId = "123"
		let expectedMeal = Meal(id: mealId, name: "Test Meal")
		repository.mockMeal = expectedMeal
		
		let expectation = self.expectation(description: "Successfully fetched meal by ID")
		
		// When
		useCase.execute(id: mealId).done { meal in
			// Then
			XCTAssertEqual(meal, expectedMeal)
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testExecuteFailure() {
		// Given
		let mealId = "123"
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		repository.mockError = expectedError
		
		let expectation = self.expectation(description: "Fetching meal by ID failed")

		// When
		useCase.execute(id: mealId).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
}
