//
//  IngredientsView.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import SwiftUI

struct IngredientsView: View {
	let meal: Meal
	
	var body: some View {
		let ingredients = meal.ingredients
		let measures = meal.measures
		
		List {
			ForEach(Array(ingredients.enumerated()), id: \.offset) { index, ingredient in
				HStack {
					Text(ingredient)
						.accessibilityLabel(ingredient)
						.frame(maxWidth: .infinity, alignment: .leading)
					
					Text(measures[index])
						.accessibilityLabel(measures[index])
						.frame(maxWidth: .infinity, alignment: .trailing)
						.foregroundColor(.gray)
				}
				.padding(.vertical, 4)
			}
		}
		.navigationTitle("Ingredients & Measures")
	}
}
