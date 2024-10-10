//
//  FiltersRepositoryImpl.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Foundation
import PromiseKit

final class FiltersRepositoryImpl: FiltersRepository {
	private let service: FiltersService
	
	init(service: FiltersService) {
		self.service = service
	}
	
	func filterBy(category: Category) -> Promise<[FilterResult]> {
		return service.filterBy(category: category)
			.map { responses in
				FilterMapper.map(responses: responses)
			}
	}
}
