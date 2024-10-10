//
//  FetchRandomMealUseCase.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation
import PromiseKit

protocol FetchRandomMealUseCase {
	func execute() -> Promise<Meal>
}

final class FetchRandomMealUseCaseImpl: FetchRandomMealUseCase {
	private let repository: MealsRepository
	
	init(repository: MealsRepository) {
		self.repository = repository
	}
	
	func execute() -> Promise<Meal> {
		return repository.getRandomMeal()
	}
}
