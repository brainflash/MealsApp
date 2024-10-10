//
//  FetchMealByIdUseCase.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation
import PromiseKit

protocol FetchMealByIdUseCase {
	func execute(id: String) -> Promise<Meal>
}

final class FetchMealByIdUseCaseImpl: FetchMealByIdUseCase {
	private let repository: MealsRepository
	
	init(repository: MealsRepository) {
		self.repository = repository
	}
	
	func execute(id: String) -> Promise<Meal> {
		return repository.getMeal(with: id)
	}
}
