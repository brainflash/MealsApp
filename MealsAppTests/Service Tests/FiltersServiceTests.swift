//
//  FiltersServiceTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class FiltersServiceTests: XCTestCase {

	var service: FiltersServiceImpl!
	var networkClient: MockNetworkClient!

	override func setUp() {
		super.setUp()
		networkClient = MockNetworkClient()
		service = FiltersServiceImpl(networkClient: networkClient)
	}

	override func tearDown() {
		service = nil
		networkClient = nil
		super.tearDown()
	}

	func testFilterByCategorySuccess() {
		// Given
		let category = Category(id: "1", category: .dessert, description: "Category 1")
		let filterResponse = FilterResponse(idMeal: "1", strMeal: "Filter Result 1", strMealThumb: "Thumb 1")
		let mockResponse = FiltersResponse(meals: [filterResponse])
		networkClient.mockFiltersResponse = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched filtered results")
		
		// When
		service.filterBy(category: category).done { results in
			// Then
			XCTAssertEqual(results, [filterResponse])
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFilterByCategoryFailure() {
		// Given
		let category = Category(id: "1", category: .dessert, description: "Category 1")
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		networkClient.mockError = expectedError
		
		let expectation = self.expectation(description: "Failed to fetch filtered results")
		
		// When
		service.filterBy(category: category).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}
