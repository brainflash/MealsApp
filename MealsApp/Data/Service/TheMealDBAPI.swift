//
//  TheMealDBAPI.swift
//  MealsApp
//
//  Created by Chris Scutt on 07/10/2024.
//

import Foundation

struct TheMealDBAPI {
	static let scheme = "https://"
	static let baseURL = "www.themealdb.com/api/json/v1/"
	
	struct Endpoints {
		static let lookup = "lookup.php"
		static let random = "random.php"
		static let categories = "categories.php"
		static let filter = "filter.php"
		static let search = "search.php"
	}
	
	static func mealURL(by id: String) -> String {
		return "\(scheme)\(baseURL)\(APIKey)/\(Endpoints.lookup)?i=\(id)"
	}
	
	static func searchURL(query: String) -> String {
		return "\(scheme)\(baseURL)\(APIKey)/\(Endpoints.search)?s=\(query)"
	}
	
	static func randomMealURL() -> String {
		return "\(scheme)\(baseURL)\(APIKey)/\(Endpoints.random)"
	}
	
	static func categoriesURL() -> String {
		return "\(scheme)\(baseURL)\(APIKey)/\(Endpoints.categories)"
	}
	
	static func filterByCategoryURL(_ filterParameter: String) -> String {
		return "\(scheme)\(baseURL)\(APIKey)/\(Endpoints.filter)?c=\(filterParameter)"
	}
}
