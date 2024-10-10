//
//  FetchRandomMealUseCaseTest.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import PromiseKit
@testable import MealsApp

class FetchRandomMealUseCaseTests: XCTestCase {

	var useCase: FetchRandomMealUseCaseImpl!
	var repository: MockMealsRepository!

	override func setUp() {
		super.setUp()
		
		repository = MockMealsRepository()
		useCase = FetchRandomMealUseCaseImpl(repository: repository)
	}

	override func tearDown() {
		useCase = nil
		repository = nil
		super.tearDown()
	}

	func testExecuteSuccess() {
		// Given
		let expectedMeal = Meal(id: "1", name: "Test Meal")
		repository.mockMeal = expectedMeal
		
		let expectation = self.expectation(description: "Successfully fetched random meal")
		
		// When
		useCase.execute().done { meal in
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
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		repository.mockError = expectedError
		
		let expectation = self.expectation(description: "Fetching random meal failed")

		// When
		useCase.execute().done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
}