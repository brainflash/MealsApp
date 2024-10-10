//
//  MainCoordinatorImpl.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

class MainCoordinator: ObservableObject, Identifiable, Coordinator {
	@Published var navigationPath = NavigationPath()
	
	var id = UUID()
	let networkClient = NetworkClientImpl()
	
	func start() {
		navigationPath = NavigationPath()
	}
	
	func navigateTo(category: Category) {
		DispatchQueue.main.async { [weak self] in
			self?.navigationPath.append(category)
		}
	}
	
	func navigateTo(meal: Meal) {
		DispatchQueue.main.async { [weak self] in
			self?.navigationPath.append(meal)
		}
	}
	
	func goBack() {
		DispatchQueue.main.async { [weak self] in
			self?.navigationPath.removeLast()
		}
	}
	
	func createMealsViewModel() -> MealsViewModel {
		let factory = MealsViewModelFactory(networkClient: networkClient)
		return factory.createViewModel(coordinator: self)
	}

	func createCategoriesViewModel() -> CategoriesViewModel {
		let factory = CategoriesViewModelFactory(networkClient: networkClient)
		return factory.createViewModel()
	}
	
	func createCategoryViewModel(category: Category) -> CategoryViewModel {
		let factory = CategoryViewModelFactory(networkClient: networkClient)
		return factory.createViewModel(category: category)
	}
	
	func createMealDetailViewModel(meal: Meal) -> MealDetailViewModel {
		let factory = MealDetailViewModelFactory(networkClient: networkClient)
		return factory.createViewModel(meal: meal)
	}
}
