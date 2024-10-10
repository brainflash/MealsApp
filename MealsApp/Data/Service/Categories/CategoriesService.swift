//
//  CategoriesService.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

protocol CategoriesService {
	func fetchCategories() -> Promise<[CategoryResponse]>
	func fetchCategory(category: Category) -> Promise<[FilterResponse]>
}

final class CategoriesServiceImpl: CategoriesService {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}

	func fetchCategories() -> Promise<[CategoryResponse]> {
		return Promise { seal in
			networkClient.fetchCategories(from: TheMealDBAPI.categoriesURL())
				.done { response in
					if let categories = response["categories"] {
						seal.fulfill(categories)
					}
				}
				.catch { error in
					seal.reject(error)
				}
		}
	}
	
	func fetchCategory(category: Category) -> Promise<[FilterResponse]> {
		return Promise { seal in
			let filterParam = category.category.filterParameter
			let url = TheMealDBAPI.filterByCategoryURL(filterParam)
			networkClient.fetchFiltered(from: url)
				.done { response in
					seal.fulfill(response.meals)
				}
				.catch { error in
					seal.reject(error)
				}
		}
	}
}
