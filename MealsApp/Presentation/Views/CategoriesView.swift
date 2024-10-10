//
//  CategoriesView.swift
//  MealsApp
//
//  Created by Chris Scutt on 08/10/2024.
//

import SwiftUI

struct CategoriesView: View {
	@StateObject var viewModel: CategoriesViewModel
	@ObservedObject var coordinator: MainCoordinator

	let columns = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	
	var body: some View {
		VStack {
			GeometryReader { geometry in
				let screenWidth = geometry.size.width
				let spacing: CGFloat = 4
				let numberOfColumns = 2
				let itemWidth = (screenWidth - spacing * CGFloat(numberOfColumns + 1)) / CGFloat(numberOfColumns)
				
				let columns = [
					GridItem(.fixed(itemWidth)),
					GridItem(.fixed(itemWidth))
				]
				
				ScrollView {
					LazyVGrid(columns: columns, spacing: 16) {
						ForEach(viewModel.categories, id: \.id) { category in
							CategoryThumbView(category: category)
								.padding()
								.border(Color.secondary, width: 2)
								.frame(minWidth: itemWidth)
								.onTapGesture {
									coordinator.navigateTo(category: category)
								}
						}
					}
				}
			}
		}
		.onAppear {
			viewModel.fetchCategories()
		}
	}
}
