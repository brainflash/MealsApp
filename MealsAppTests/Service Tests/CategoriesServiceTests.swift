//
//  CategoriesServiceTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class CategoriesServiceTests: XCTestCase {

	var service: CategoriesServiceImpl!
	var networkClient: MockNetworkClient!

	override func setUp() {
		super.setUp()
		networkClient = MockNetworkClient()
		service = CategoriesServiceImpl(networkClient: networkClient)
	}

	override func tearDown() {
		service = nil
		networkClient = nil
		super.tearDown()
	}

	func testFetchCategoriesSuccess() {
		// Given
		let categoryResponse = CategoryResponse(idCategory: "1", strCategory: "Category 1", strCategoryThumb: "Thumb", strCategoryDescription: "Description")
		let mockResponse: [String: [CategoryResponse]] = ["categories": [categoryResponse]]
		networkClient.mockCategoryResponses = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched categories")
		
		// When
		service.fetchCategories().done { categories in
			// Then
			XCTAssertEqual(categories, [categoryResponse])
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchCategoriesFailure() {
		// Given
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		networkClient.mockError = expectedError
		
		let expectation = self.expectation(description: "Failed to fetch categories")

		// When
		service.fetchCategories().done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchCategorySuccess() {
		// Given
		let category = Category(id: "1", category: .dessert, description: "Category 1")
		let filterResponse = FilterResponse(idMeal: "1", strMeal: "Filtered Result 1", strMealThumb: "Thumb 1")
		let mockResponse = FiltersResponse(meals: [filterResponse])
		networkClient.mockFiltersResponse = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched category")
		
		// When
		service.fetchCategory(category: category).done { results in
			// Then
			XCTAssertEqual(results, [filterResponse])
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchCategoryFailure() {
		// Given
		let category = Category(id: "1", category: .starter, description: "Category 123")
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		networkClient.mockError = expectedError
		
		let expectation = self.expectation(description: "Failed to fetch category")

		// When
		service.fetchCategory(category: category).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as NSError, expectedError)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
}

