//
//  MainView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct MainView: View {
	@StateObject var viewModel: MealsViewModel
	@ObservedObject var coordinator: MainCoordinator

	var body: some View {
		NavigationStack(path: $coordinator.navigationPath) {
			MealsView(viewModel: viewModel, coordinator: coordinator)
				.navigationDestination(for: Category.self) { category in
					let viewModel = coordinator.createCategoryViewModel(category: category)
					CategoryView(viewModel: viewModel, coordinator: coordinator)
				}
				.navigationDestination(for: Meal.self) { meal in
					let viewModel = coordinator.createMealDetailViewModel(meal: meal)
					MealDetailView(viewModel: viewModel, coordinator: coordinator)
				}
		}
	}
}
