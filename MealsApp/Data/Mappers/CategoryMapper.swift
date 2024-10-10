//
//  CategoryMapper.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class CategoryMapper {
	static func map(response: CategoryResponse) -> Category {
		return Category(id: response.idCategory,
						category: Category.MealCategory(rawValue: response.strCategory.lowercased()) ?? .none,
						thumb: URL(string: response.strCategoryThumb) ?? nil,
						description: response.strCategoryDescription)
	}
	
	static func map(responses: [CategoryResponse]) -> [Category] {
		return responses.map { map(response: $0) }
	}
}
