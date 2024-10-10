//
//  MealsService.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation
import PromiseKit

protocol MealsService {
	func fetchMealBy(id: String) -> Promise<MealResponse>
	func fetchRandomMeal() -> Promise<MealResponse>
	func searchForMealsBy(query: String) -> Promise<[MealResponse]>
}

final class MealsServiceImpl: MealsService {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func searchForMealsBy(query: String) -> Promise<[MealResponse]> {
		let url = TheMealDBAPI.searchURL(query: query)
		return fetchMeals(from: url)
	}

	func fetchMealBy(id: String) -> Promise<MealResponse> {
		let url = TheMealDBAPI.mealURL(by: id)
		return fetchMeal(from: url)
	}
	
	func fetchRandomMeal() -> Promise<MealResponse> {
		return fetchMeal(from: TheMealDBAPI.randomMealURL())
	}
	
	private func fetchMeal(from url: String) -> Promise<MealResponse> {
		return Promise { seal in
			networkClient.fetchMeals(from: url)
				.done { response in
					if let meals = response["meals"],
					   let firstMeal = meals.first {
						seal.fulfill(firstMeal)
					} else {
						seal.reject(MealsServiceError.noMealsFound)
					}
				}
				.catch { error in
					print("MealsService fetchMeal error: \(error)")
					seal.reject(error)
				}
		}
	}
	
	private func fetchMeals(from url: String) -> Promise<[MealResponse]> {
		return Promise { seal in
			networkClient.fetchMeals(from: url)
				.done { response in
					if let meals = response["meals"] {
						seal.fulfill(meals)
					}
				}
				.catch { error in
					seal.reject(MealsServiceError.decodingError)
				}
		}
	}
	
}
