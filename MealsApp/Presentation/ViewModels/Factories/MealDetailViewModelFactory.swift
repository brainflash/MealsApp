//
//  MealDetailViewModelFactory.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class MealDetailViewModelFactory {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func createViewModel(meal: Meal) -> MealDetailViewModel {
		let service = MealsServiceImpl(networkClient: networkClient)
		let repository = MealsRepositoryImpl(service: service)
		let useCase = FetchMealByIdUseCaseImpl(repository: repository)
		return MealDetailViewModel(meal: meal, fetchMealByIdUseCase: useCase)
	}
}
