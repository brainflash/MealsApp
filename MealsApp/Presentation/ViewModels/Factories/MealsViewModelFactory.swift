//
//  MealsViewModelFactory.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class MealsViewModelFactory {
	private let networkClient: NetworkClient
	
	init(networkClient: NetworkClient) {
		self.networkClient = networkClient
	}
	
	func createViewModel(coordinator: MainCoordinator) -> MealsViewModel {
		let service = MealsServiceImpl(networkClient: networkClient)
		let repository = MealsRepositoryImpl(service: service)
		let randomMealUseCase = FetchRandomMealUseCaseImpl(repository: repository)
		let searchForMealUseCase = SearchForMealUseCaseImpl(repository: repository)
		return MealsViewModel(fetchRandomMealUseCase: randomMealUseCase,
							  searchForMealUseCase: searchForMealUseCase,
							  coordinator: coordinator)
	}
}
