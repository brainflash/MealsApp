//
//  CategoriesViewModelFactory.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class CategoriesViewModelFactory {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func createViewModel() -> CategoriesViewModel {
		let service = CategoriesServiceImpl(networkClient: networkClient)
		let repository = CategoriesRepositoryImpl(service: service)
		let useCase = FetchCategoriesUseCaseImpl(repository: repository)
		return CategoriesViewModel(fetchCategoriesUseCase: useCase)
	}
}
