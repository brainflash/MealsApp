//
//  FiltersService.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

protocol FiltersService {
	func filterBy(category: Category) -> Promise<[FilterResponse]>
}

final class FiltersServiceImpl: FiltersService {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}

	func filterBy(category: Category) -> Promise<[FilterResponse]> {
		let filterParameter = category.category.rawValue.capitalized
		let filterURL = TheMealDBAPI.filterByCategoryURL(filterParameter)
		
		return fetchFiltered(from: filterURL)
	}
	
	private func fetchFiltered(from url: String) -> Promise<[FilterResponse]> {
		return Promise { seal in
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
