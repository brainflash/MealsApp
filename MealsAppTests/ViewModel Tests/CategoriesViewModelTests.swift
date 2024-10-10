//
//  CategoriesViewModelTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import Combine
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class CategoriesViewModelTests: XCTestCase {
	
	var viewModel: CategoriesViewModel!
	var fetchCategoriesUseCase: MockFetchCategoriesUseCase!
	
	override func setUp() {
		super.setUp()
		
		// Initialize the mocks
		fetchCategoriesUseCase = MockFetchCategoriesUseCase()
		
		// Initialize SUT
		viewModel = CategoriesViewModel(fetchCategoriesUseCase: fetchCategoriesUseCase)
	}
	
	override func tearDown() {
		viewModel = nil
		fetchCategoriesUseCase = nil
		super.tearDown()
	}
	
	func testFetchCategoriesSuccess() {
		// Given
		let expectedCategories = [
			Category(id: "1", category: .beef, thumb: URL(string: "http://test.xyz/ab.jpg")!, description: "Description 1"),
			Category(id: "2", category: .vegetarian, thumb: URL(string: "http://test.xyz/cd.jpg")!, description: "Description 2")
		]
		fetchCategoriesUseCase.mockResult = expectedCategories
		
		let expectation = self.expectation(description: "Categories fetched successfully")
		
		// When
		viewModel.fetchCategories()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.viewModel.categories, expectedCategories)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchCategoriesFailure() {
		// Given
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		fetchCategoriesUseCase.mockError = expectedError
		
		let expectation = self.expectation(description: "Categories fetch failed")
		
		// When
		viewModel.fetchCategories()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertTrue(self.viewModel.categories.isEmpty)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}
