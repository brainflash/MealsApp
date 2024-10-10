//
//  CategoriesRepositoryImpl.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

final class CategoriesRepositoryImpl: CategoriesRepository {
	private let service: CategoriesService
	
	init(service: CategoriesService) {
		self.service = service
	}
	
	func getCategories() -> Promise<[Category]> {
		return service.fetchCategories()
			.map { responses in
				return CategoryMapper.map(responses: responses)
			}
	}
	
	func getCategory(category: Category) -> Promise<[FilterResult]> {
		return service.fetchCategory(category: category)
			.map { responses in
				return FilterMapper.map(responses: responses)
			}
	}
}
