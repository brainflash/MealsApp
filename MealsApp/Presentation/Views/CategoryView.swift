//
//  CategoryView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct CategoryView: View {
	@StateObject var viewModel: CategoryViewModel
	@ObservedObject var coordinator: MainCoordinator

	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		ScrollView {
			LazyVGrid(columns: columns, spacing: 16) {
				ForEach(viewModel.results, id: \.id) { result in
					FilterThumbView(result: result)
						.padding()
						.border(Color.secondary, width: 2)
						.onTapGesture {
							coordinator.navigateTo(meal: Meal(id: result.id, name: result.meal))
						}
				}
			}
		}
		.navigationTitle("\(viewModel.category.displayText) category")
		.onAppear {
			viewModel.fetchFilterResults()
		}
	}
}
