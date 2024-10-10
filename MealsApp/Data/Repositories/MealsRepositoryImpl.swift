//
//  MealsRepositoryImpl.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation
import PromiseKit

final class MealsRepositoryImpl: MealsRepository {
	private let service: MealsService
	
	init(service: MealsService) {
		self.service = service
	}

	func getMeal(with id: String) -> Promise<Meal> {
		return service.fetchMealBy(id: id)
			.map { response in
				return MealMapper.map(response: response)
			}
	}

	func getRandomMeal() -> Promise<Meal> {
		return service.fetchRandomMeal()
			.map { response in
				return MealMapper.map(response: response)
			}
	}
	
	func searchForMealsBy(query: String) -> Promise<[Meal]> {
		return service.searchForMealsBy(query: query)
			.map { responses in
				return MealMapper.map(responses: responses)
			}
	}

}
