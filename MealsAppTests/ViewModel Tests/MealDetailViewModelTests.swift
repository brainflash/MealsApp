//
//  MealDetailViewModelTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import Combine
import PromiseKit

@testable import MealsApp

class MealDetailViewModelTests: XCTestCase {
	
	var viewModel: MealDetailViewModel!
	var fetchMealByIdUseCase: MockFetchMealByIdUseCase!
	var meal: Meal!
	
	override func setUp() {
		super.setUp()
		
		// Initialize the mocks
		fetchMealByIdUseCase = MockFetchMealByIdUseCase()
		meal = Meal(id: "1", name: "Test Meal")
		
		// Initialize SUT
		viewModel = MealDetailViewModel(meal: meal, fetchMealByIdUseCase: fetchMealByIdUseCase)
	}
	
	override func tearDown() {
		viewModel = nil
		fetchMealByIdUseCase = nil
		meal = nil
		super.tearDown()
	}
	
	func testFetchMealSuccess() {
		// Given
		let updatedMeal = Meal(id: "1", name: "Updated Meal")
		fetchMealByIdUseCase.mockResult = updatedMeal
		
		let expectation = self.expectation(description: "Meal fetched successfully")
		
		// When
		viewModel.fetchMeal()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.viewModel.meal, updatedMeal)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchMealFailure() {
		// Given
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		fetchMealByIdUseCase.mockError = expectedError
		
		let expectation = self.expectation(description: "Meal fetch failed")
		
		// When
		viewModel.fetchMeal()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.viewModel.meal, self.meal)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
}
