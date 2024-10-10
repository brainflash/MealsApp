//
//  FetchCategoryUseCase.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

protocol FilterByCategoryUseCase {
	func execute(category: Category) -> Promise<[FilterResult]>
}

final class FilterByCategoryUseCaseImpl: FilterByCategoryUseCase {
	private let repository: FiltersRepository
	
	init(repository: FiltersRepository) {
		self.repository = repository
	}
	
	func execute(category: Category) -> Promise<[FilterResult]> {
		return repository.filterBy(category: category)
	}
}
