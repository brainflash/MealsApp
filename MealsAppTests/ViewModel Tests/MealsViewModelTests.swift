//
//  MealsViewModelTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import Combine
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class MealsViewModelTests: XCTestCase {
	
	var viewModel: MealsViewModel!
	var fetchRandomMealUseCase: MockFetchRandomMealUseCase!
	var searchForMealUseCase: MockSearchForMealUseCase!
	var coordinator: MockMainCoordinator!
	var cancellables: Set<AnyCancellable> = []
	
	override func setUp() {
		super.setUp()
		
		// Initialize the mocks
		fetchRandomMealUseCase = MockFetchRandomMealUseCase()
		searchForMealUseCase = MockSearchForMealUseCase()
		coordinator = MockMainCoordinator()
		
		// Initialize SUT
		viewModel = MealsViewModel(
			fetchRandomMealUseCase: fetchRandomMealUseCase,
			searchForMealUseCase: searchForMealUseCase,
			coordinator: coordinator
		)
	}
	
	override func tearDown() {
		viewModel = nil
		fetchRandomMealUseCase = nil
		searchForMealUseCase = nil
		coordinator = nil
		cancellables = []
		
		super.tearDown()
	}
	
	func testFetchRandomMealSuccess() {
		// Given
		let expectedMeal = Meal(id: "123", name: "Pizza")
		fetchRandomMealUseCase.mockResult = expectedMeal
		
		let expectation = self.expectation(description: "Expected meal fetched successfully")
		
		// When
		viewModel.fetchRandomMeal()
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			XCTAssertEqual(self.coordinator.navigatedMeal?.name, expectedMeal.name)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchRandomMealFailure() {
		// Given
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		fetchRandomMealUseCase.mockError = expectedError
		
		// When
		viewModel.fetchRandomMeal()
		
		// Then
		XCTAssertNil(coordinator.navigatedMeal)
	}
	
	func testSearchForMealSuccess() {
		// Given
		let query = "Pizza"
		let expectedResults = [Meal(id: "123", name: "Pizza"), Meal(id: "345", name: "Pepperoni Pizza")]
		searchForMealUseCase.mockResults = expectedResults
		
		let expectation = self.expectation(description: "Expected results received")
		
		// When
		viewModel.query = query
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			XCTAssertEqual(self.viewModel.results.count, expectedResults.count)
			XCTAssertEqual(self.viewModel.results.map { $0.name }, expectedResults.map { $0.name })
			XCTAssertTrue(self.viewModel.isSearching)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testSearchForMealEmptyQuery() {
		// Given
		let query = ""
		
		let expectation = self.expectation(description: "Not searching and results empty")
		
		// When
		viewModel.query = query
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			XCTAssertTrue(self.viewModel.results.isEmpty)
			XCTAssertFalse(self.viewModel.isSearching)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testSearchForMealFailure() {
		// Given
		let query = "chicken"
		let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
		searchForMealUseCase.mockError = expectedError
		
		let expectation = self.expectation(description: "Results empty")
		
		// When
		viewModel.query = query
		
		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			XCTAssertEqual(self.viewModel.results.count, 0)
			expectation.fulfill()
		}
		wait(for: [expectation], timeout: 1.0)
	}
}
