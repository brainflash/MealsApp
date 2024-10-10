//
//  FilterMapper.swift
//  MealsApp
//
//  Created by Chris Scutt on 09/10/2024.
//

import Foundation

class FilterMapper {
	static func map(response: FilterResponse) -> FilterResult {
		return FilterResult(id: response.idMeal,
							meal: response.strMeal,
							thumb: URL(string: response.strMealThumb) ?? nil)
	}
	
	static func map(responses: [FilterResponse]) -> [FilterResult] {
		return responses.map { map(response: $0) }
	}
}
