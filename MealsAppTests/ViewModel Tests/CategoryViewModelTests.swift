//
//  CategoryViewModelTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import Combine
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class CategoryViewModelTests: XCTestCase {
	
	var viewModel: CategoryViewModel!
	var filterByCategoryUseCase: MockFilterByCategoryUseCase!
	var category: Category!
	
	override func setUp() {
		super.setUp()
		
		// Initialize the mocks
		filterByCategoryUseCase = MockFilterByCategoryUseCase()
		category = Category(id: "123", category: .breakfast, thumb: URL(string: "https://test.xyz/feb.jpg")!, description: "Breakfast")
		
		// Initialize SUT
		viewModel = CategoryViewModel(
			category: category,
			filterByCategoryUseCase: filterByCategoryUseCase
		)
	}
	
	override func tearDown() {
		viewModel = nil
		filterByCategoryUseCase = nil
		category = nil
		super.tearDown()
	}
	
	func testFetchFilterResultsSuccess() {
		// Given
		let expectedResults = [FilterResult(id: "34", meal: "Meal 1", thumb: URL(string: "https://test.xyz/dec.jpg")!),
							   FilterResult(id: "35", meal: "Meal 2", thumb: URL(string: "https://test.xyz/jam.jpg")!)]
		filterByCategoryUseCase.mockResults = expectedResults
		
		let expectation = self.expectation(description: "Filter results fetched successfully")
		
		// When
		viewModel.fetchFilterResults()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.viewModel.results, expectedResults)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchFilterResultsFailure() {
		// Given
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		filterByCategoryUseCase.mockError = expectedError
		
		let expectation = self.expectation(description: "Filter results fetch failed")
		
		// When
		viewModel.fetchFilterResults()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertTrue(self.viewModel.results.isEmpty)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}
