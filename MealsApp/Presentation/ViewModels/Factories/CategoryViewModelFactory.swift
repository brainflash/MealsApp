//
//  CategoryViewModelFactory.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class CategoryViewModelFactory {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func createViewModel(category: Category) -> CategoryViewModel {
		let service = FiltersServiceImpl(networkClient: networkClient)
		let repository = FiltersRepositoryImpl(service: service)
		let useCase = FilterByCategoryUseCaseImpl(repository: repository)
		return CategoryViewModel(category: category, filterByCategoryUseCase: useCase)
	}
}
