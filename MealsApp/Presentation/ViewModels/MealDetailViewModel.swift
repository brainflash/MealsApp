//
//  MealDetailViewModel.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Combine
import Foundation
import PromiseKit

class MealDetailViewModel: ObservableObject {
	@Published var meal: Meal
	
	private var fetchMealByIdUseCase: FetchMealByIdUseCase
	
	init(meal: Meal, fetchMealByIdUseCase: FetchMealByIdUseCase) {
		self.meal = meal
		self.fetchMealByIdUseCase = fetchMealByIdUseCase
	}
	
	func fetchMeal() {
		fetchMealByIdUseCase.execute(id: meal.id)
			.done { [weak self] result in
				self?.meal = result
			}
			.catch { error in
				print("fetchMealById error: \(error)")
			}
	}
}
