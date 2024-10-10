//
//  NetworkClientTests.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import XCTest
import PromiseKit
@testable import MealsApp

class NetworkClientTests: XCTestCase {
	
	var networkClient: NetworkClientImpl!
	
	override func setUp() {
		super.setUp()
		
		// Register the custom URL protocol
		URLProtocol.registerClass(MockURLProtocol.self)

		// Reset stubs
		MockURLProtocol.stubResponse = nil
		MockURLProtocol.stubError = nil
		
		// Create a URLSession with mock protocol
		let configuration = URLSessionConfiguration.default
		let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: nil)
		networkClient = NetworkClientImpl(session: session)
	}
	
	override func tearDown() {
		// Unregister the custom URL protocol
		URLProtocol.unregisterClass(MockURLProtocol.self)
		
		networkClient = nil
		super.tearDown()
	}

	func testFetchMealSuccess() {
		// Given
		let mockResponse = MealsResponse(meals: [Meal(id: "123", name: "Test Meal")])
		MockURLProtocol.stubResponse = try? JSONEncoder().encode(mockResponse)

		let url = "https://test.com/meal"
		let expectation = self.expectation(description: "Fetch meal successful")

		// When
		networkClient.fetchMeal(from: url).done { response in
			let meal = response.meals.first!
			// Then
			XCTAssertEqual(meal.id, "123")
			XCTAssertEqual(meal.name, "Test Meal")
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchMealFailure() {
		// Given
		MockURLProtocol.stubError = NSError(domain: "Test", code: 1, userInfo: nil)

		let url = "https://test.com/meal"
		let expectation = self.expectation(description: "Fetch meal failure")

		// When
		networkClient.fetchMeal(from: url).done { _ in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertNotNil(error)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchMealsSuccess() {
		// Given
		let meal1 = createMealResponse(idMeal: "123", strMeal: "Test Meal 1", strCategory: "Cat 1")
		let meal2 = createMealResponse(idMeal: "234", strMeal: "Test Meal 2", strCategory: "Cat 2")
		let mockResponse = ["meals" : [meal1, meal2]]
		MockURLProtocol.stubResponse = try? JSONEncoder().encode(mockResponse)

		let url = "https://test.com/meal"
		let expectation = self.expectation(description: "Fetch meal successful")

		// When
		networkClient.fetchMeals(from: url).done { response in
			let meals: [MealResponse] = response["meals"]!
			let meal1 = meals[0]
			let meal2 = meals[1]
			
			// Then
			XCTAssertEqual(meal1.idMeal, "123")
			XCTAssertEqual(meal1.strMeal, "Test Meal 1")
			XCTAssertEqual(meal1.strCategory, "Cat 1")
			XCTAssertEqual(meal2.idMeal, "234")
			XCTAssertEqual(meal2.strMeal, "Test Meal 2")
			XCTAssertEqual(meal2.strCategory, "Cat 2")
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchCategoriesSuccess() {
		// Given
		let cat1 = CategoryResponse(idCategory: "123", strCategory: "Cat 1", strCategoryThumb: "Thumb 1", strCategoryDescription: "Desc 1")
		let cat2 = CategoryResponse(idCategory: "234", strCategory: "Cat 2", strCategoryThumb: "Thumb 2", strCategoryDescription: "Desc 2")
		let mockResponse = ["categories": [cat1, cat2]]
		MockURLProtocol.stubResponse = try? JSONEncoder().encode(mockResponse)

		let url = "https://test.com/categories"
		let expectation = self.expectation(description: "Fetch categories successful")

		// When
		networkClient.fetchCategories(from: url).done { response in
			let cats: [CategoryResponse] = response["categories"]!
			let cat1 = cats[0]
			let cat2 = cats[1]
			
			// Then
			XCTAssertEqual(cat1.idCategory, "123")
			XCTAssertEqual(cat1.strCategory, "Cat 1")
			XCTAssertEqual(cat1.strCategoryThumb, "Thumb 1")
			XCTAssertEqual(cat1.strCategoryDescription, "Desc 1")
			XCTAssertEqual(cat2.idCategory, "234")
			XCTAssertEqual(cat2.strCategory, "Cat 2")
			XCTAssertEqual(cat2.strCategoryThumb, "Thumb 2")
			XCTAssertEqual(cat2.strCategoryDescription, "Desc 2")
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	func testFetchFilteredSuccess() {
		// Given
		let filter1 = FilterResponse(idMeal: "123", strMeal: "Meal 1", strMealThumb: "Thumb 1")
		let filter2 = FilterResponse(idMeal: "234", strMeal: "Meal 2", strMealThumb: "Thumb 2")
		let mockResponse = FiltersResponse(meals: [filter1, filter2])
		MockURLProtocol.stubResponse = try? JSONEncoder().encode(mockResponse)

		let url = "https://test.com/filtered"
		let expectation = self.expectation(description: "Fetch filtered successful")

		// When
		networkClient.fetchFiltered(from: url).done { response in
			let filterResponse = response.meals
			let f1 = filterResponse[0]
			let f2 = filterResponse[1]
			
			// Then
			XCTAssertEqual(f1.idMeal, "123")
			XCTAssertEqual(f1.strMeal, "Meal 1")
			XCTAssertEqual(f1.strMealThumb, "Thumb 1")
			XCTAssertEqual(f2.idMeal, "234")
			XCTAssertEqual(f2.strMeal, "Meal 2")
			XCTAssertEqual(f2.strMealThumb, "Thumb 2")
			expectation.fulfill()
		}.catch { _ in
			XCTFail("Expected success but got failure")
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	func testBadURL() {
		// Given
		let mockResponse = MealsResponse(meals: [Meal(id: "123", name: "Test Meal")])
		MockURLProtocol.stubResponse = try? JSONEncoder().encode(mockResponse)

		let url = ""
		let expectation = self.expectation(description: "Fetch meal failure")

		// When
		networkClient.fetchMeal(from: url).done { response in
			XCTFail("Expected failure but got success")
		}.catch { error in
			// Then
			XCTAssertNotNil(error)
			expectation.fulfill()
		}

		wait(for: [expectation], timeout: 1.0)
	}
	
	private func createMealResponse(idMeal: String, strMeal: String, strCategory: String) -> MealResponse {
		return MealResponse(idMeal: idMeal, strMeal: strMeal, strDrinkAlternate: "", strCategory: strCategory, strArea: "", strInstructions: "", strMealThumb: "", strTags: "", strYoutube: "", strIngredient1: "", strIngredient2: "", strIngredient3: "", strIngredient4: "", strIngredient5: "", strIngredient6: "", strIngredient7: "", strIngredient8: "", strIngredient9: "", strIngredient10: "", strIngredient11: "", strIngredient12: "", strIngredient13: "", strIngredient14: "", strIngredient15: "", strIngredient16: "", strIngredient17: "", strIngredient18: "", strIngredient19: "", strIngredient20: "", strMeasure1: "", strMeasure2: "", strMeasure3: "", strMeasure4: "", strMeasure5: "", strMeasure6: "", strMeasure7: "", strMeasure8: "", strMeasure9: "", strMeasure10: "", strMeasure11: "", strMeasure12: "", strMeasure13: "", strMeasure14: "", strMeasure15: "", strMeasure16: "", strMeasure17: "", strMeasure18: "", strMeasure19: "", strMeasure20: "", strSource: "", strImageSource: "", strCreativeCommonsConfirmed: "", dateModified: "")
	}
}
