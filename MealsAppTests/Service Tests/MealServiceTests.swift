//
//  MealServiceTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import PromiseKit
@testable import MealsApp

class MealsServiceTests: XCTestCase {

	var service: MealsServiceImpl!
	var networkClient: MockNetworkClient!

	override func setUp() {
		super.setUp()
		networkClient = MockNetworkClient()
		service = MealsServiceImpl(networkClient: networkClient)
	}

	override func tearDown() {
		service = nil
		networkClient = nil
		super.tearDown()
	}

	func testFetchMealByIdSuccess() {
		// Given
		let mealResponse = createMealResponse(idMeal: "1", strMeal: "Spaghetti Bolognese", strCategory: "Pasta")
		let mockResponse: [String: [MealResponse]] = ["meals": [mealResponse]]
		networkClient.mockMealResponses = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched meal by ID")
		
		// When
		service.fetchMealBy(id: "1").done { meal in
			// Then
			XCTAssertEqual(meal, mealResponse)
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchMealByIdFailure() {
		// Given
		networkClient.mockError = MealsServiceError.noMealsFound
		
		let expectation = self.expectation(description: "Failed to fetch meal by ID")

		// When
		service.fetchMealBy(id: "1").done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as? MealsServiceError, MealsServiceError.noMealsFound)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchRandomMealSuccess() {
		// Given
		let mealResponse = createMealResponse(idMeal: "1", strMeal: "Random Meal", strCategory: "Chicken")
		let mockResponse: [String: [MealResponse]] = ["meals": [mealResponse]]
		networkClient.mockMealResponses = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched random meal")
		
		// When
		service.fetchRandomMeal().done { meal in
			// Then
			XCTAssertEqual(meal, mealResponse)
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testFetchRandomMealNoMealsFailure() {
		// Given
		let mockResponse: [String: [MealResponse]] = [:]
		networkClient.mockMealResponses = mockResponse
		
		let expectation = self.expectation(description: "Successfully fetched random meal")
		
		// When
		service.fetchMealBy(id: "1").done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as? MealsServiceError, MealsServiceError.noMealsFound)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	func testSearchForMealsByQuerySuccess() {
		// Given
		let mealResponse1 = createMealResponse(idMeal: "1", strMeal: "Meal 1", strCategory: "Lasagna Sandwiches")
		let mealResponse2 = createMealResponse(idMeal: "1", strMeal: "Meal 2", strCategory: "Lasagne")
		let mockResponses: [String: [MealResponse]] = ["meals": [mealResponse1, mealResponse2]]
		networkClient.mockMealResponses = mockResponses
		
		let expectation = self.expectation(description: "Successfully searched meals by query")
		
		// When
		service.searchForMealsBy(query: "Pasta").done { meals in
			// Then
			XCTAssertEqual(meals, [mealResponse1, mealResponse2])
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}
		
		wait(for: [expectation], timeout: 1.0)
	}

	func testSearchForMealsByQueryFailure() {
		// Given
		networkClient.mockError = MealsServiceError.decodingError
		
		let expectation = self.expectation(description: "Failed to search meals by query")

		// When
		service.searchForMealsBy(query: "Pizza").done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertEqual(error as? MealsServiceError, MealsServiceError.decodingError)
			expectation.fulfill()
		}
		
		wait(for: [expectation], timeout: 1.0)
	}
	
	private func createMealResponse(idMeal: String, strMeal: String, strCategory: String) -> MealResponse {
		return MealResponse(idMeal: idMeal, strMeal: strMeal, strDrinkAlternate: "", strCategory: strCategory, strArea: "", strInstructions: "", strMealThumb: "", strTags: "", strYoutube: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")
	}
}
