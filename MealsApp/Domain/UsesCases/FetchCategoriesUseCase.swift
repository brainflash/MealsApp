//
//  FetchCategoriesUseCase.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

protocol FetchCategoriesUseCase {
	func execute() -> Promise<[Category]>
}

final class FetchCategoriesUseCaseImpl: FetchCategoriesUseCase {
	private let repository: CategoriesRepository
	
	init(repository: CategoriesRepository) {
		self.repository = repository
	}
	
	func execute() -> Promise<[Category]> {
		return repository.getCategories()
	}
}
