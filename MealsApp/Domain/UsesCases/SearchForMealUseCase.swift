//
//  SearchForMealUseCase.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation
import PromiseKit

protocol SearchForMealUseCase {
	func execute(query: String) -> Promise<[Meal]>
}

final class SearchForMealUseCaseImpl: SearchForMealUseCase {
	private let repository: MealsRepository
	
	init(repository: MealsRepository) {
		self.repository = repository
	}
	
	func execute(query: String) -> Promise<[Meal]> {
		return repository.searchForMealsBy(query: query)
	}
}
