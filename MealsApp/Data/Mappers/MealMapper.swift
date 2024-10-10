//
//  MealsMapper.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class MealMapper {
	static func map(response: MealResponse) -> Meal {
		let ingredientsAndMeasures = response.getIngredientsAndMeasures()
		
		return Meal(
			id: response.idMeal,
			name: response.strMeal,
			category: Category.MealCategory(rawValue: response.strCategory.lowercased()) ?? .none,
			area: response.strArea ?? "",
			instructions: response.strInstructions ?? "",
			ingredients: ingredientsAndMeasures.ingredients,
			measures: ingredientsAndMeasures.measures,
			thumb: URL(string: response.strMealThumb ?? "") ?? nil,
			youTube: URL(string: response.strYoutube ?? "") ?? nil,
			source: response.strSource
		)
	}
	
	static func map(responses: [MealResponse]) -> [Meal] {
		return responses.map { map(response: $0) }
	}
}
