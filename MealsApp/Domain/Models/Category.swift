//
//  Category.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation

struct Category: Codable, Identifiable, Hashable {
	var id: String
	var category: MealCategory
	var thumb: URL?
	var description: String
	var displayText: String { return category.rawValue.capitalized }
	
	enum MealCategory: String, Codable, Identifiable, CaseIterable {
		case none
		case beef
		case chicken
		case dessert
		case lamb
		case miscellaneous
		case pasta
		case pork
		case seafood
		case side
		case starter
		case vegan
		case vegetarian
		case breakfast
		case goat
		
		var id: String { return rawValue }
		var filterParameter: String { return rawValue.capitalized }
	}
}
