//
//  Meal.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation

struct Meal: Codable, Identifiable, Hashable {
	let id: String
	let name: String
	var category: Category.MealCategory = .none
	var area: String = ""
	var instructions: String = ""
	var ingredients: [String] = []
	var measures: [String] = []
	var thumb: URL? = nil
	var tags: [String] = []
	var youTube: URL? = nil
	var source: String? = ""
}
