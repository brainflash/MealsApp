//
//  CategoryViewModel.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Combine
import Foundation
import PromiseKit

class CategoryViewModel: ObservableObject {
	@Published var results: [FilterResult] = []

	let category: Category
	private var filterByCategoryUseCase: FilterByCategoryUseCase
	
	init(category: Category,
		 filterByCategoryUseCase: FilterByCategoryUseCase,
		 cancellables: Set<AnyCancellable> = Set<AnyCancellable>()) {
		self.category = category
		self.filterByCategoryUseCase = filterByCategoryUseCase
	}
	
	func fetchFilterResults() {
		filterByCategoryUseCase.execute(category: category)
			.done { [weak self] results in
				self?.results = results
			}
			.catch { [weak self] error in
				print("filterByCategory error: \(error)")
				self?.results = []
			}
	}
}
