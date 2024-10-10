//
//  MealsAppMocks.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

import struct MealsApp.Category

@testable import MealsApp

class MockFetchRandomMealUseCase: FetchRandomMealUseCase {
	var mockResult: Meal?
	var mockError: Error?
	
	func execute() -> Promise<Meal> {
		return Promise { seal in
			if let result = mockResult {
				seal.fulfill(result)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockFetchMealByIdUseCase: FetchMealByIdUseCase {
	var mockResult: Meal?
	var mockError: Error?
	
	func execute(id: String) -> Promise<Meal> {
		return Promise { seal in
			if let result = mockResult {
				seal.fulfill(result)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockSearchForMealUseCase: SearchForMealUseCase {
	var mockResults: [Meal]?
	var mockError: Error?

	func execute(query: String) -> Promise<[Meal]> {
		return Promise { seal in
			if let results = mockResults {
				seal.fulfill(results)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockFetchCategoriesUseCase: FetchCategoriesUseCase {
	var mockResult: [Category]?
	var mockError: Error?
	
	func execute() -> Promise<[Category]> {
		return Promise { seal in
			if let result = mockResult {
				seal.fulfill(result)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockFilterByCategoryUseCase: FilterByCategoryUseCase {
	var mockResults: [FilterResult]?
	var mockError: Error?
	
	func execute(category: Category) -> Promise<[FilterResult]> {
		return Promise { seal in
			if let results = mockResults {
				seal.fulfill(results)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockMealsRepository: MealsRepository {
	var mockMeal: Meal?
	var mockMeals: [Meal]?
	var mockError: Error?

	func getRandomMeal() -> Promise<Meal> {
		return Promise { seal in
			if let meal = mockMeal {
				seal.fulfill(meal)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
	
	func getMeal(with id: String) -> Promise<Meal> {
		return Promise { seal in
			if let meal = mockMeal {
				seal.fulfill(meal)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
	
	func searchForMealsBy(query: String) -> Promise<[Meal]> {
		return Promise { seal in
			if let meals = mockMeals {
				seal.fulfill(meals)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}

}

class MockFiltersRepository: FiltersRepository {
	var mockResults: [FilterResult]?
	var mockError: Error?

	func filterBy(category: Category) -> Promise<[FilterResult]> {
		return Promise { seal in
			if let results = mockResults {
				seal.fulfill(results)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockNetworkClient: NetworkClient {
	var mockResponse: MealsResponse?
	var mockMealResponses: [String: [MealResponse]]?
	var mockCategoryResponses: [String: [CategoryResponse]]?
	var mockFiltersResponse: FiltersResponse?
	var mockError: Error?

	func fetchMeal(from url: String) -> Promise<MealsResponse> {
		return Promise { seal in
			if let response = mockResponse {
				seal.fulfill(response)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}

	func fetchMeals(from url: String) -> Promise<[String: [MealResponse]]> {
		return Promise { seal in
			if let responses = mockMealResponses {
				seal.fulfill(responses)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
	
	func fetchCategories(from url: String) -> Promise<[String:[CategoryResponse]]> {
		return Promise { seal in
			if let responses = mockCategoryResponses {
				seal.fulfill(responses)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
	
	func fetchFiltered(from url: String) -> Promise<FiltersResponse> {
		return Promise { seal in
			if let response = mockFiltersResponse {
				seal.fulfill(response)
			} else if let error = mockError {
				seal.reject(error)
			}
		}
	}
}

class MockURLProtocol: URLProtocol {
	static var stubResponse: Data?
	static var stubError: Error?
	
	override class func canInit(with request: URLRequest) -> Bool {
		return true
	}
	
	override class func canonicalRequest(for request: URLRequest) -> URLRequest {
		return request
	}
	
	override func startLoading() {
		if let error = MockURLProtocol.stubError {
			self.client?.urlProtocol(self, didFailWithError: error)
		} else if let data = MockURLProtocol.stubResponse {
			self.client?.urlProtocol(self, didLoad: data)
		}
		self.client?.urlProtocolDidFinishLoading(self)
	}
	
	override func stopLoading() {
		// Noop
	}
}

class MockMainCoordinator: MainCoordinator {
	
	var startCalled: Bool = false
	var goBackCalled: Bool = false
	var navigatedMeal: Meal?
	var navigatedCategory: Category?

	override func start() {
		startCalled = true
	}
	
	override func goBack() {
		goBackCalled = true
	}

	override func navigateTo(meal: Meal) {
		navigatedMeal = meal
	}

	override func navigateTo(category: Category) {
		navigatedCategory = category
	}

}
