//
//  CategoriesViewModel.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import Combine
import Foundation
import PromiseKit

class CategoriesViewModel: ObservableObject {
	@Published var categories: [Category] = []
	@Published var searchResults: [Meal] = []
	
	private var fetchCategoriesUseCase: FetchCategoriesUseCase

	init(fetchCategoriesUseCase: FetchCategoriesUseCase) {
		self.fetchCategoriesUseCase = fetchCategoriesUseCase
	}
	
	func fetchCategories() {
		fetchCategoriesUseCase.execute()
			.done { [weak self] result in
				self?.categories = result
			}
			.catch { [weak self] error in
				print("fetchCategories error: \(error)")
				self?.categories = []
			}
	}
}
