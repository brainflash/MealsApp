//
//  FetchCategoryUseCaseTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import XCTest
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class FilterByCategoryUseCaseTests: XCTestCase {

	var useCase: FilterByCategoryUseCaseImpl!
	var repository: MockFiltersRepository!

	override func setUp() {
		super.setUp()

		// Initialize mocks
		repository = MockFiltersRepository()

		// Initialize SUT
		useCase = FilterByCategoryUseCaseImpl(repository: repository)
	}

	override func tearDown() {
		useCase = nil
		repository = nil
		super.tearDown()
	}

	func testExecuteSuccess() {
		// Given
		let category = Category(id: "1", category: .breakfast, description: "Test Category")
		let expectedResults = [
			FilterResult(id: "1", meal: "Chicken Pie", thumb: nil),
			FilterResult(id: "2", meal: "Beef Stew", thumb: nil)
		]
		repository.mockResults = expectedResults
		
		let expectation = self.expectation(description: "Successfully filtered by category")
		
		// When
		useCase.execute(category: category).done { results in
			// Then
			XCTAssertEqual(results, expectedResults)
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testExecuteFailure() {
		// Given
		let category = Category(id: "1", category: .dessert, description: "Test Category")
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		repository.mockError = expectedError
		
		let expectation = self.expectation(description: "Filtering by category failed")

		// When
		useCase.execute(category: category).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
}

