//
//  MealsView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct MealsView: View {
	@ObservedObject var viewModel: MealsViewModel
	@ObservedObject var coordinator: MainCoordinator
	@State var isSearching: Bool = false
	
	var body: some View {
		VStack {
			if isSearching {
				List(viewModel.results, id: \.id) { meal in
					MealListItem(meal: meal)
						.onTapGesture {
							coordinator.navigateTo(meal: meal)
						}
				}
			} else {
				let categoriesViewModel = coordinator.createCategoriesViewModel()
				CategoriesView(viewModel: categoriesViewModel, coordinator: coordinator)
					.padding()
			}
		}
		.navigationTitle("Choose a meal")
		.searchable(text: $viewModel.query, isPresented: $isSearching, prompt: "Search for a meal")
		.toolbar {
			ToolbarItem(placement: .navigationBarTrailing) {
				Button(action: {
					viewModel.fetchRandomMeal()
				}) {
					HStack {
						Text("Random meal")
						Image(systemName: "questionmark.circle")
					}
				}
			}
		}
	}
}
